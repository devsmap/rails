class Employees::JobsController < Employees::ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: JobDatatable.new(params) }
    end
  end
  
end
