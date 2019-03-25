class JobsController < ApplicationController
  add_flash_types :fail, :success
  def index
    @jobs = Job.all
  end

  def import
    begin
      Job.import(params[:file])
      redirect_to root_url, success: "Importation réussie"
    rescue StandardError => e
      redirect_to root_url, fail: "Fichier ou données incorrects, échec de l'importation ------ #{e}"
    end
  end

  def save_number_of_men_women
    @jobs = Job.all
    @jobs.each do |job|
      puts 'ceci est number_men dans le contrôleur : ', Job.new.count_parity(job.job_title)
    end
  end
end
