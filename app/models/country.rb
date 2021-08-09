class Country < ApplicationRecord

  has_many :states, dependent: :destroy
  
  def self.default_scope
    where(is_active: true)
  end

end
