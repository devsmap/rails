class CompanyDatatable < AjaxDatatablesRails::ActiveRecord
  
  include ActionView::Helpers::DateHelper

  def view_columns
    @view_columns ||= {
      id:      { source: "Company.id", orderable: false, searchable: false },
      name:    { source: "Company.name", cond: :like, searchable: true, orderable: true },
      total:   { source: "Company.jobs.count", searchable: false, orderable: false },
      actions: { source: "Company.id", searchable: false, orderable: false }
    }    
  end

  def data
    records.map do |record|
      {
        id:      record.id,
        name:    record.name,
        total:   record.jobs.count,
        actions: record.id
      }
    end
  end

  def get_raw_records
    Company.all
  end

end
