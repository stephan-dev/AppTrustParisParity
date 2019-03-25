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

    begin
      @jobs.each do |job|

        men_count = Job.new.count_men(job.job_title).to_i
        women_count = Job.new.count_women(job.job_title).to_i

        job.update(men: men_count, women: women_count)
      end

    rescue
      puts "erreur"
    end
  end
end
