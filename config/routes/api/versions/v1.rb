namespace :v1 do

  # Categories
  get "/categories", to: "categories#index"

  # Pins default by category
  get "/pins/:category_id/default", to: "pins#default"

  # Jobs by category and city
  get "/jobs/:category_id/:city_id", to: "jobs#index"

end
