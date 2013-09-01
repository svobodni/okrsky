class DistrictTownHall < TownHall

  belongs_to :district
  delegate :municipality, :to => :district

end
