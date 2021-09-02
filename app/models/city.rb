class City < ApplicationRecord

  belongs_to :state
  has_many   :jobs, dependent: :destroy

end
