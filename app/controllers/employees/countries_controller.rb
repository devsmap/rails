class Employees::CountriesController < Employees::ApplicationController
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: CountryDatatable.new(params) }
    end
  end
  
end
