module ApplicationHelper
  include Pagy::Frontend
  
  def current_user
    if employee_signed_in?
      current_employee
    end
  end  
end
