class Category < ApplicationRecord

  has_many   :childrens, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent,    class_name: "Category", optional: true

  def self.default_scope
    where(is_active: true)
  end    
  
end
