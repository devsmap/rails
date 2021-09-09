class CountryDatatable < AjaxDatatablesRails::ActiveRecord
  
  include ActionView::Helpers::DateHelper

  def view_columns
    @view_columns ||= {
      id:      { source: "Country.id",   searchable: false, orderable: false },
      name:    { source: "Country.name", searchable: true,  orderable: true  },
      actions: { source: "Country.id",   searchable: false, orderable: false }
    }    
  end

  def data
    records.map do |record|
      {
        id:      record.id,
        name:    record.name,
        actions: record.id
      }
    end
  end

  def get_raw_records
    Country.all
  end

end
