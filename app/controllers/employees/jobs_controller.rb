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

  def update
    if @job.update(job_params)
      redirect_to employees_jobs_path, notice: "Sucesso"
    else
      render action: 'edit'
    end
  end


  private

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:category_id, :title, :company, :city_id, :link, :description)
    end

end
