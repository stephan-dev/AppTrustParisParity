
#require 'httparty'
#require "erb"

class FetchParity
  include HTTParty
  # include ERB::Util

  base_uri 'https://opendata.paris.fr/api/'

  # body = JSON.parse(response.body)

  def initialize(job)
    puts 'ceci est job', job
    @job = job
    puts 'ceci est @job', @job
    @options = { query: {dataset: 'bilan-social-effectifs-non-titulaires-permanents', facet: ['annee','collectivite','type_de_contrat','emplois','niveau'], 'refine.emplois' => @job } } 
  end
  
  def ratio
    self.class.disable_rails_query_string_format
    @res = self.class.get('/records/1.0/search/', @options)

    puts
    puts '//////////'
    puts
    puts @res.request.last_uri.to_s
    puts
    puts '//////////'

    puts @res

  end


  def parse
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

    rescue
      puts
      puts 'ÉCHEC'
      puts
    end
  end

end