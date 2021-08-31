class Api::V1::CategoriesController < Api::V1::ApplicationController
  
  def index
    categories_json = []

    Category.all.each do |category|
      categories_json << {
        id: category.id,
        name: category.name
      }
    end

    render json: {
      data: categories_json
    }
  end

end
