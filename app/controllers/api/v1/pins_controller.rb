class Api::V1::PinsController < Api::V1::ApplicationController
  
  def default
    pins_default_json = []

    jobs = Job.select(" jobs.category_id
                       ,cities.latitude
                       ,cities.longitude
                       ,sum(1) as total")
              .joins(:city)
              .where(category: params[:category_id])
              .group('jobs.category_id, cities.id')

    jobs.each do |job|
      pins_default_json << {
        category_id: job.category_id,
        latitude: job.latitude,
        longitude: job.longitude,
        total: job.total,
      }
    end

    render json: {
      data: pins_default_json
    }
  end

end
