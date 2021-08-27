class Employees::JobsController < Employees::ApplicationController

  def index
    @jobs = Job.all.order(created_at: :desc) 
  end
  
end
