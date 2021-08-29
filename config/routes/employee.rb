devise_for :employees

# as :employee do
#   patch '/employees/confirmation' => 'employees/devise/confirmations#update',
#         via: :patch,
#         as: :update_employee_confirmation
# end

# unauthenticated :employee do
#   devise_scope :employee do
#     root to: 'employees/sessions#new', :as => 'employee_unauthenticated'
#   end
# end

namespace :employees do

  # Dashbord
  get '/' => 'dashboard#index', as: :dashboard

  # Employees
  resources :employees do
    member do
      get :resend_confirmation
    end
  end

  # Companies
  resources :companies, only: [:index] do
    # member do
    #   get '/tab/:tab', action: :show, as: :show,
    #                    tab: /users/
    # end
  end

  # Jobs
  get '/jobs'      => 'jobs#index'
  get '/jobs/ajax' => 'jobs#ajax'
  # resources :jobs, only: [:index] do
  #   # member do
  #   #   get '/tab/:tab', action: :show, as: :show,
  #   #                    tab: /users/
  #   # end
  # end

end
