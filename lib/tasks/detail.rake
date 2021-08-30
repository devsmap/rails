namespace :google do
  namespace :jobs do
    desc "Detail a job"
    task detail: :environment do
      Google.where(is_detailed: false).each do |google|
        detail(google)
      end
    end
  end
end

def detail(google)
  save(google) if city_exist?(google)
end

def city_exist?(google)
  city_in_state = select_city(google)
  unless city_in_state.present?
    google.update(is_detailed: true, deleted_reason: "city does not exist")
    google.destroy
    
    return false
  end  

  true
end

def select_city(google)
  city = format_city(google.city)
  google.state.cities.where("unaccent(name) = '#{city}'").last
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

def save(google)
  city = select_city(google)
  published_at = format_published_at(google.published_at)

  company = Company.with_deleted.find_by_slug("#{google.company.to_s.parameterize}")
  unless company.present?
    company = Company.create(name: google.company)
  end

  Job.create(
    category_id: google.category_id,
    city_id: city.id,
    company_id: company.id,    
    is_active: true,
    title: google.title,
    description: google.description,
    via: google.via,
    link: google.link,
    published_at: published_at,
    time_zone: google.state.country.time_zone,
    gogole_job_id: google.job_id
  )
  
  google.update(is_detailed: true)
end
