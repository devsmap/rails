class Employees::ApplicationController < ApplicationController

  before_action :authenticate_employee!

  private

    def user_not_authorized(exception)
     policy_name = exception.policy.class.to_s.underscore

     flash[:alert] = I18n.t "pundit.#{policy_name}.#{exception.query}", default: 'Você não tem permissão para essa área.'
     redirect_to(request.referrer || root_employee_path)
    end  

end
