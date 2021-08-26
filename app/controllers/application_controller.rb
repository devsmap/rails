class ApplicationController < ActionController::Base  

  before_action :set_cache_headers

  layout :resolve_layout

  private

    def current_user
      current_employee
    end
        
    def resolve_layout
      if signed_in?
        "application.html"
      else
        "login"
      end
    end

    def set_cache_headers
      response.headers["Pragma"]        = "no-cache"
      response.headers["Expires"]       = "Fri, 01 Jan 1990 00:00:00 GMT"
      response.headers["Cache-Control"] = "no-cache, no-store"
    end  

    # Overwriting the sign_in redirect path method
    def after_sign_in_path_for(resource)
      employees_dashboard_path if resource.is_a?(Employee)
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource)
      employee_session_path if resource == :employee
    end    

end
