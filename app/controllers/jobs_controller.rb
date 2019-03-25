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

      redirect_to root_path

    rescue
      puts "erreur"
      redirect_to root_path
    end
  end

  def update_percentage
    @jobs = Job.all
    @jobs.each do |job|
      if job.men != 0 && job.men != nil && job.women != 0 && job.women != nil
        ratio = job.women.to_f / job.men.to_f
        job.update(ratio: ratio)
        if ratio > 0.85
          job.update(valiid: "valide")
        elsif ratio < 0.85
          job.update(valiid: "invalide")
        end
      end
    end

    redirect_to root_path
  end
end
