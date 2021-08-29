module ApplicationHelper
  def current_user
    if employee_signed_in?
      current_employee
    end
  end  
end
