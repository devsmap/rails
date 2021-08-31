class Api::V1::JobsController < Api::V1::ApplicationController
  
  include ActionView::Helpers::DateHelper

  def index
    jobs_json = []

    jobs = Job.select(" jobs.*
                       ,categories.name as category_name
                       ,companies.name as company_name")
              .joins(:category, :company)
              .where(category_id: params[:category_id].to_i, city_id: params[:city_id].to_i)
              .order(published_at: :desc)

    jobs.each do |job|
      jobs_json << {
        id: job.id,
        category_name: job.category_name,
        title: job.title,
        company: job.company_name,
        description: job.description,
        link: job.link,
        published_at: job.published_at,
        published_at_word: time_ago_in_words(job.published_at)
      }
    end

    render json: {
      data: jobs_json
    }
  end

end
