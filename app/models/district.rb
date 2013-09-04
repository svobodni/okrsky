class District < ActiveRecord::Base

  belongs_to :municipality
  # has_one :district_town_halls
  has_one :town_hall, class_name: DistrictTownHall

  default_scope { order("#{self.table_name}.name ASC") }

end
