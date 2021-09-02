namespace :google do
  namespace :jobs do
    desc "Scrap google jobs."
    task collect: :environment do

      starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      Country.all.each do |country|
        State.where(country_id: country.id).each do |state|
          Category.where(parent_id: nil).each do |category|  
            collect = collect(country, state, category)
            save_jobs(country, state, category, collect)
          end
        end
      end

      Rake::Task["google:jobs:detail"].invoke

      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      puts (ending - starting)      
    end
  end
end

def collect(country, state, category)
  scrape_erro      = false
  try_change_date  = 0 
  jobs_by_requests = nil

  loop do
    url = build_url(category, state, country, scrape_erro, try_change_date)

    response = HTTParty.get('http://api.scrapestack.com/scrape?access_key=' + '90967f75298c7d267c8e29f0db409701' + '&proxy_location=' + country.google_gl + '&premium_proxy=1&url=' + CGI.escape(url))

    puts "#{url}".blue + " (#{response.code})".white  

    if response.code == 200 

      jobs_by_requests = work_html(response.body, category, state) 

      try_change_date = (jobs_by_requests.size == 0 && try_change_date == 0) ? 1 : 0
    
      scrape_erro = false
    else
      scrape_erro = true
    end

    break if scrape_erro == false && try_change_date == 0
      
    sleep 2
  end

  jobs_by_requests
end

def build_url(category, state, country, scrape_erro, try_change_date)
  url = "https://www.google.com/search?"
  url += "q=#{CGI.escape(state.name)}+#{CGI.escape(category.name)}"
  url += "&ibp=htl;jobs"
  url += "&uule=#{state.google_uule}"
  url += "&hl=#{country.google_hl}"
  url += "&gl=#{country.google_gl}"
  url += "&location=#{CGI.escape(state.name)}"
  url += "&chips=date_posted:week"
  
  url += (try_change_date == 1) ? "&htichips=date_posted:week&htischips=date_posted:week" : "&chips=date_posted:week"

  url
end

def work_html(html, category, state) 
  doc = Nokogiri::HTML(html)

  block_all_jobs = doc.css("div.gws-plugins-horizon-jobs__tl-lvc ul li")

  jobs = []
  block_all_jobs.each do |block|

    ordem_div = block.xpath('div/div[1]/div[2]').present? ? 1 : 2
    
    block_defaul = block.xpath("div/div[#{ordem_div}]/div[2]/div/div")

    job_id       = block.xpath("div/div[#{ordem_div}]/div[1]/div//@data-encoded-doc-id").to_s
    title        = block_defaul.xpath('div[2]/div[2]//text()').to_s
    company      = block_defaul.xpath('div[3]/div/div[1]//text()').to_s
    city         = block_defaul.xpath('div[3]/div/div[2]//text()').to_s
    via          = block_defaul.xpath('div[3]/div/div[3]//text()').to_s
    published_at = block_defaul.xpath('div[3]/div/div[4]/span[1]/span[2]//text()').to_s
    description  = block.search('span[style="line-height:1.5em"]//text()').to_s.squeeze(' ')
    link         = block.xpath("div/div[#{ordem_div}]/div[1]/div/div/g-scrolling-carousel/div/div/div/span/a/@href").to_s
    token        = Base64.encode64(title+company+city).gsub("\n", ' ').strip

    # Se a vaga já foi cadastrada pula o loop
    next if Google.with_deleted.exists?(job_id: "#{job_id}")

    if !(jobs.any? {|h| h[:token] == token})
      if !((city.empty?) || city.match(/Qualquer lugar|Anywhere|Brasil/) || (city == state.name))
        if (published_at.match(/hora|hour|minuto|minute|dia|day|día/))

          next if published_at.match(/dia|day/) && published_at.delete("^0-9").to_i > 15

          regex_category_name =  category.name
          regex_category_name += category.childrens.exists? ? "|" + category.childrens.pluck(:name).join("|") : ""
                    
          if (title.match(/#{regex_category_name}/))

            puts  "#{job_id} - #{title} - #{company} - #{city} - #{published_at}".red

            jobs << {
              job_id: job_id,
              title: title,
              company: company,
              city: city,
              via: via,
              published_at: published_at,
              description: description,
              link: link,              
              token: token
            }     
          end          
        end
      end
    end
  end 

  jobs
end

def save_jobs(country, state, category, collect)
  collect.each do |job|
    unless Google.with_deleted.exists?(job_id: "#{job[:job_id]}")
      Google.create(
        category_id: category.id,
        state_id: state.id,
        job_id: job[:job_id],
        title: job[:title],
        company: job[:company],
        city: job[:city],
        via: job[:via],
        published_at: job[:published_at],
        description: job[:description],
        link: job[:link],
        token: job[:token]
      )            
    end           
  end
end

def write_html(state, html)
  File.open('google_' + state.id.to_s + '.html', 'w') { |file| file.write(html.force_encoding("UTF-8")) }
end
