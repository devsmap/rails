class Api::V1::PinsController < Api::V1::ApplicationController
  
  def default
    pins_default_json = []

    jobs = Job.select(" jobs.category_id
                       ,cities.id as city_id
                       ,cities.latitude
                       ,cities.longitude
                       ,sum(1) as total")
              .joins(:city, :company)
              .where(category: params[:category_id].to_i, company: {is_customer: false})
              .group('jobs.category_id, cities.id')

    jobs.each do |job|
      pins_default_json << {
        category_id: job.category_id,        
        total: job.total, 
        city_id: job.city_id,           
        latitude: job.latitude,
        longitude: job.longitude
      }
    end

    render json: {
      data: pins_default_json
    }
  end

  def customer

  end  

end
