devise_for :employees, :controllers => {
  sessions:      "employees/devise/sessions",
  registrations: "employees/devise/registrations",
  confirmations: "employees/devise/confirmations",
  passwords:     "employees/devise/passwords"
}

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

# namespace :employees do

#   # Solutions
#   namespace :helpers do
#     get  '/',                           action: 'index'
#     get  '/not-received-email-welcome', action: 'email_welcome',  as: :email_welcome
#     post '/not-received-email-welcome', action: 'resend_welcome', as: :resend_welcome
#   end

#   # Dashbord
#   get '/' => 'dashboard#index', as: :dashboard

#   # Employees
#   resources :employees do
#     member do
#       get :resend_confirmation
#     end
#   end

#   # Companies
#   resources :companies, except: [:show, :destroy] do
#     member do
#       get '/tab/:tab', action: :show, as: :show,
#                        tab: /users/
#     end
#   end

# end
