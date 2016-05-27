crumb :root do
  link "Úvod", root_path
end

crumb :regions do
  link "Kraje", wizard_path(:region)
end

crumb :region do |region|
  link region.name, wizard_path(:municipality, region_id: region.id)
  parent :regions
end

crumb :municipality do |municipality|
 link municipality.name, wizard_path(:ward, municipality_id: municipality.id)
 parent :region, municipality.region
end

crumb :district do |district|
 link district.name, wizard_path(:ward, district_id: district.id)
 parent :municipality, district.municipality
end

crumb :ward do |ward|
  link "Registrace", "#"
  parent :commisaries
end

crumb :commisaries do |commisary|
  link "Osoby", commisaries_path
end

crumb :commisary do |commisary|
  link commisary.name, "#"
  # commisary.name
  parent :commisaries if current_user
  parent :root if current_commisary
end

crumb :commisary_edit do |commisary|
  link "Oprava", "#"
  parent :commisary, commisary
end

crumb :sign_in do
  link "Přihlášení", "#"
end
