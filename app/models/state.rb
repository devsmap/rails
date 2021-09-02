class State < ApplicationRecord

  belongs_to :country
  
  has_many :cities, dependent: :destroy
  has_many :google, dependent: :destroy
  
end
