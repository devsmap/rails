class Api::V1::PinsController < Api::V1::ApplicationController
  
  def default
    pins_json = []

    jobs = Job.select(" jobs.category_id
                       ,cities.latitude
                       ,cities.longitude
                       ,sum(1) as total")
              .joins(:city)
              .where(category: 1)
              .group('jobs.category_id, cities.id')

    jobs.each do |job|
      pins_json << {
        category_id: job.category_id,
        latitude: job.latitude,
        longitude: job.longitude,
        total: job.total,
      }
    end

    render json: {
      data: pins_json
    }
  end

end
