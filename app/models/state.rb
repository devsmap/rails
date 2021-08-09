class State < ApplicationRecord

  belongs_to :country
  
  has_many :cities, dependent: :destroy
  has_many :google, dependent: :destroy

  def self.default_scope
    where(is_active: true).order(name: :asc)
  end  
  
end
