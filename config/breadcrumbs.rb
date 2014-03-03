crumb :root do
  link "Home", root_path
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
  link ward.external_id, wizard_path(:commisary, ward_id: ward.id)
  if ward.district
    parent :district, ward.district
  else
    parent :municipality, ward.municipality
  end
end