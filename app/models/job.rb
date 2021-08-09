class Job < ApplicationRecord
  acts_as_paranoid
  
  include LocalDateTimeAttrReaders
  time_zone_attr_reader :time_zone
  local_date_attr_reader :published_at 

  belongs_to :category
  belongs_to :city
end
