class City < ApplicationRecord

  belongs_to :state

  def self.default_scope
    where(is_active: true).order(name: :asc)
  end  
  
end
