Rails.application.routes.draw do

  get '/', to: 'pages#welcome', as: :root_user 
  
end
