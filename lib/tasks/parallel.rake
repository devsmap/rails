# namespace :google do
#   namespace :jobs do
#     desc "Scrap google jobs."
#     task parallel: :environment do

#       starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#         collect #call the scraper function


#       # Country.all.each do |country|
#       #   State.where(country_id: country.id).each do |state|
#       #     Category.where(parent_id: nil).each do |category|  
#       #       collect = collect(country, state, category)
#       #     end
#       #   end
#       # end

#       ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
#       puts (ending - starting)      
#     end
#   end
# end

# def collect
#   url = [
#     "https://www.google.com/search?q=Acre+React&ibp=htl;jobs&uule=w+CAIQICIMQWNyZSwgQnJhemls&hl=pt-BR&gl=br&location=Acre#fpstate=tldetail",
#     "https://www.google.com/search?q=Alagoas+React&ibp=htl;jobs&uule=w+CAIQICIPQWxhZ29hcywgQnJhemls&hl=pt-BR&gl=br&location=Alagoas#fpstate=tldetail",
#     "https://www.google.com/search?q=Amap%C3%A1+React&ibp=htl;jobs&uule=w+CAIQICIOQW1hcMOhLCBCcmF6aWw&hl=pt-BR&gl=br&location=Amap%C3%A1#fpstate=tldetail",
#     "https://www.google.com/search?q=Amazonas+React&ibp=htl;jobs&uule=w+CAIQICIQQW1hem9uYXMsIEJyYXppbA&hl=pt-BR&gl=br&location=Amazonas#fpstate=tldetail",
#     "https://www.google.com/search?q=Bahia+React&ibp=htl;jobs&uule=w+CAIQICINQmFoaWEsIEJyYXppbA&hl=pt-BR&gl=br&location=Bahia#fpstate=tldetail"
#   ]

#   mutex = Mutex.new
#   threads = []
#   url.each do |val|
#       threads << Thread.new(val) { |single_url|
          
#            response = HTTParty.get('http://api.scrapestack.com/scrape?access_key=' + '90967f75298c7d267c8e29f0db409701' + '&premium_proxy=1&&url=' + CGI.escape(single_url))

#           # .css('div.PA10') #Top level division having the stock details.
#           # stock = listing.css('div.FL').css('div#content_full').css('div#content_bse').css('div.brdb').css('div#Bse_Prc_tick_div').css('span#Bse_Prc_tick').text
#           # open the file history.txt in locked state so that other
#           # threads cannot append to the file at the same time.
#           mutex.synchronize do
#               file = File.open("history.txt", "a")
#               p "#{single_url}"
#               file.puts "#{single_url}"
#               file.close
#           end
#       }
#   end

#   # after every thread is done, close the main thread.
#   ThreadsWait.all_waits(*threads)
# end

# def build_url(category, state, country, scrape_erro, try_change_date)
#   url = "https://www.google.com/search?"
#   url += "q=#{CGI.escape(state.name)}+#{CGI.escape(category.name)}"
#   url += "&ibp=htl;jobs"
#   url += "&uule=#{state.google_uule}"
#   url += "&hl=#{country.google_hl}"
#   url += "&gl=#{country.google_gl}"
#   url += "&location=#{CGI.escape(state.name)}#fpstate=tldetail"
  
#   url
# end
