class FetchParity
  require "erb"
  include ERB::Util

  def example
    url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&facet=collectivite&facet=type_de_contrat&facet=emplois&facet=niveau&refine.emplois=TECHNICIENS%20SUPERIEURS%20D%27ADMINISTRATIONS%20PARISIENNES'
    response = HTTParty.get(url)

    parsed = JSON.parse(response.to_s)

    puts parsed["records"][0]["fields"]["nombre_d_hommes"]
  end

  def construct_url(employee)
    # employee = Employee.first

    if employee.try(:job_level) == "CHARGE DE MISSION AGENT D'EXECUTION"
      employee.job_level = "AGENT D'EXECUTION"
    end

    if employee.try(:job_specialty)
      # déplacé collectivité plus haut, et remplacé facet par refine (ayant eu "commune n'est pas une facet") l'ayant vu comme supercatégorie dans un exemple de retour d'api...
      # copié la même plus bas
      # essayé de préciser tous les refine.qqch
      url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&refine='+employee.collectivity+'facet=annee&refine.annee='+employee.year.to_s+'&facet=type_de_contrat&refine.type_de_contrat='+url_encode(employee.contract_type)+'&facet=emplois&refine.emplois='+url_encode(employee.job_title)+'&facet=niveau&refine.niveau='+url_encode(employee.job_level)+'&refine.emplois='+url_encode(employee.job_specialty)
    else
      url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&refine='+employee.collectivity+'facet=annee&refine.annee='+employee.year.to_s+'&facet='+'&facet=type_de_contrat&refine.type_de_contrat='+url_encode(employee.contract_type)+'&facet=emplois&refine.emplois='+url_encode(employee.job_title)+'&facet=niveau&refine.niveau='+url_encode(employee.job_level)
    end
  end

end


# employees = Employee.all

# employees.each do |employee|
#   employee
# end