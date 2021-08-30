class Employees::CompaniesController < Employees::ApplicationController
  
  before_action :set_company, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: CompanyDatatable.new(params) }
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

    def set_company
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:category_id, :title, :company_id, :city_id, :link, :description)
    end

end
