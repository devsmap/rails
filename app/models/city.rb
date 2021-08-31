class City < ApplicationRecord

  belongs_to :state
  has_many   :jobs, dependent: :destroy

  def self.default_scope
    where(is_active: true).order(name: :asc)
  end  
  
end
