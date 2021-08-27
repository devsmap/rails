class Employees::JobsController < Employees::ApplicationController

  def index
    @jobs = Job.all.order(published_at: :desc) 
  end
  
end
