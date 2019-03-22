class EmployeesController < ApplicationController
  add_flash_types :fail, :success
  def index
    @employees = Employee.all
  end

  def import
    begin
      Employee.import(params[:file])
      redirect_to root_url, success: "Importation réussie"
    rescue StandardError => e
      redirect_to root_url, fail: "Fichier ou données incorrects, échec de l'importation ------ #{e}"
    end
  end
end
