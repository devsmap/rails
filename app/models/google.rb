class Google < ApplicationRecord
  self.table_name = "google"

  acts_as_paranoid

  belongs_to :category
  belongs_to :state
end
