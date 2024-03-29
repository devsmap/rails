class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  if Rails.env.development? || Rails.env.test?
    default_url_options host: "localhost"
  elsif Rails.env.production? || Rails.env.staging?
    default_url_options host: "devsmap.com"
  end

  # routes to subdomain
  # devsmap.com/employees
  # ============================================================================
  draw :employee

  # devsmap.com/api
  # ============================================================================
  draw :api  

  # devsmap.com/api
  # ============================================================================
  # get '/', to: 'pages#welcome', as: :root_user 

  # Exceptions
  # ============================================================================
  # match "/500", to: "errors#server_error_500", via: :all
  # match "/404", to: "errors#server_error_404", via: :all
end
