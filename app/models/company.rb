class Company < ApplicationRecord

  has_many :jobs, dependent: :destroy

  before_create :set_slug

  acts_as_paranoid
  
  private

  def set_slug
    self.slug = name.to_s.parameterize
  end 

end
