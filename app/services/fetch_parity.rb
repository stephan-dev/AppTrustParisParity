
#require 'httparty'
#require "erb"

class FetchParity
  include HTTParty
  # include ERB::Util

  attr_accessor :total_men, :total_women

  base_uri 'https://opendata.paris.fr/api/'

  # body = JSON.parse(response.body)

  def initialize(job)
    @job = job
    @options = { query: {dataset: 'bilan-social-effectifs-non-titulaires-permanents', facet: ['annee','collectivite','type_de_contrat','emplois','niveau'], 'refine.emplois' => @job } } 
  end
  
  def fetch_raw_data_for_job
    self.class.disable_rails_query_string_format
    @res = self.class.get('/records/1.0/search/', @options)

    puts # check in Terminal the URL httparty requests
    puts @res.request.last_uri.to_s
    puts
    # puts @res

  end


  def parse_and_count_sex_ratio
    begin

      # myparsed = JSON.parse @res
      # could be easier with parsing with JSON first => creates an object rather than a hash

      number_of_men = 0
      number_of_women = 0

      @res.parsed_response["records"].each do |hashh|
        number_of_men += hashh["fields"]["nombre_d_hommes"].to_i
        number_of_women += hashh["fields"]["nombre_de_femmes"].to_i
      end

      puts "le nombre d'hommes est", number_of_men
      puts "le nombre de femmes est", number_of_women

      @total_men = number_of_men
      @total_women = number_of_women
      return @total_men

    rescue
      puts
      puts 'ÉCHEC'
      puts
    end
  end

  def perform
    fetch_raw_data_for_job
    parse_and_count_sex_ratio
    puts "ceci est total_men dans le service : ", @total_men
    # return @total_men
    return @total_men
    return @total_women
  end

end