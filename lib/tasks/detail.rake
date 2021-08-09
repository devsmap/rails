namespace :google do
  namespace :jobs do
    desc "Detail a job"
    task detail: :environment do
      Google.where(is_detailed: false).each do |job|
        detail(job)
      end
    end
  end
end

def detail(job)
  save(job) if city_exist?(job)
end

def city_exist?(job)
  city_in_state = select_city(job)
  unless city_in_state.present?
    job.update(is_detailed: true, deleted_reason: "city does not exist")
    job.destroy
    
    return false
  end  

  true
end

def select_city(job)
  city = format_city(job.city)
  job.state.cities.where("unaccent(name) = '#{city}'").last
end

def format_city(city)
  city = city.unaccent.gsub!(/[^A-Za-z]/, ' ')
  city = city.nil? ? city : city.split('  ')[0]
end

def format_published_at(published_at)
  time_now = Time.now
  published_at_int = published_at.delete("^0-9").to_i

  case published_at
  when /hora|hour|minuto|minute/
    case published_at
    when /hora|hour|/
      (time_now - published_at_int.hours).to_time
    when /minuto|minute/
      (time_now - published_at_int.minutes).to_time
    end
  when /dia|day/
    (time_now.to_date - published_at_int).to_time
  end      
end

def save(job)
  city = select_city(job)
  published_at = format_published_at(job.published_at)

  Job.create(
    category_id: job.category_id,
    city_id: city.id,
    is_active: true,
    title: job.title,
    company: job.company,
    description: job.description,
    via: job.via,
    link: job.link,
    published_at: published_at,
    time_zone: job.state.country.time_zone,
    gogole_job_id: job.job_id
  )
  
  job.update(is_detailed: true)
end
