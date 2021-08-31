class JobDatatable < AjaxDatatablesRails::ActiveRecord
  
  include ActionView::Helpers::DateHelper

  def view_columns
    @view_columns ||= {
      id:           { source: "Job.id", orderable: false, searchable: false },
      category:     { source: "Job.category.name", searchable: false, orderable: false },
      company:      { source: "Job.company.name", searchable: false, orderable: false },
      city:         { source: "Job.city.name", searchable: false, orderable: false },
      title:        { source: "Job.title", cond: :like, searchable: true, orderable: true },
      published_at: { source: "Job.published_at", cond: :like, searchable: false, orderable: true },
      actions:      { source: "Job.id", searchable: false, orderable: false }
    }    
  end

  def data
    records.map do |record|
      {
        id:           record.id,
        category:     record.category.name,
        company:      record.company.name,
        city:         record.city.name,
        title:        record.title,
        published_at: time_ago_in_words(record.published_at),
        actions:      record.id
      }
    end
  end

  def get_raw_records
    Job.all
  end

end
