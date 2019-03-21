class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def import
    begin
      Employee.import(params[:file])
      redirect_to root_url, notice: "Importation réussie"
    rescue StandardError => e
      puts '/////////'
      puts
      puts e 
      puts
      puts '///////////'
      redirect_to root_url, notice: "Fichier ou données incorrects, échec de l'importation"
    end
  end
end
