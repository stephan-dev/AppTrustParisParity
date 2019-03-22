class FetchParity
  def example
    url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&facet=collectivite&facet=type_de_contrat&facet=emplois&facet=niveau&refine.emplois=TECHNICIENS%20SUPERIEURS%20D%27ADMINISTRATIONS%20PARISIENNES'
    response = HTTParty.get(url)

    parsed = JSON.parse(response.to_s)

    puts parsed["records"][0]["fields"]["nombre_d_hommes"]
  end


  URI.escape("Techniciens supérieurs d'administrations parisiennes", "', ")

  def construct_url
    employee = Employee.first

    if employee.job_specialty != nil
      url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&refine.annee='+employee.year.to_s+'&facet='+employee.collectivity+'&facet=type_de_contrat&refine='+URI.escape(employee.contract_type, "', ")+'&facet=emplois&refine='+URI.escape(employee.job_title, "', ")+'&facet=niveau&refine.niveau='+URI.escape(employee.job_level, "', ")+'&refine.emplois='+URI.escape(employee.job_specialty, "', ")
    else
      url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&refine.annee='+employee.year.to_s+'&facet='+employee.collectivity+'&facet=type_de_contrat&refine='+URI.escape(employee.contract_type, "', ")+'&facet=emplois&refine='+URI.escape(employee.job_title, "', ")+'&facet=niveau&refine.niveau='+URI.escape(employee.job_level, "', ")
    end
  end

end


# employees = Employee.all

# employees.each do |employee|
#   employee
# end