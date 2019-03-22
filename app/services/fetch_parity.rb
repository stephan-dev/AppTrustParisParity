class FetchParity
  url = 'https://opendata.paris.fr/api/records/1.0/search/?dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&facet=collectivite&facet=type_de_contrat&facet=emplois&facet=niveau&refine.emplois=TECHNICIENS%20SUPERIEURS%20D%27ADMINISTRATIONS%20PARISIENNES'
  response = HTTParty.get(url)

  parsed = JSON.parse(response.to_s)

  puts parsed["records"][0]["fields"]["nombre_d_hommes"]
end