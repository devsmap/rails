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
    if @company.update(company_params)
      redirect_to employees_companies_path, notice: "Sucesso"
    else
      render action: 'edit'
    end
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name)
    end

end
