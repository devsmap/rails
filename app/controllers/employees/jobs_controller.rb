class Employees::JobsController < Employees::ApplicationController
  
  before_action :set_job, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: JobDatatable.new(params) }
    end
  end
  
  def edit
  end

  private

    def set_job
      @job = Job.find(params[:id])
    end

end
