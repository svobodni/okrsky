class DistrictTownHall < TownHall

  belongs_to :district
  delegate :municipality, :to => :district

  def heraldry_path
  	"http://vdp.cuzk.cz/vdp/ruian/mestskecasti/#{district.id}/znak"
  end

  def flag_path
    "http://vdp.cuzk.cz/vdp/ruian/mestskecasti/#{district.id}/vlajka"
  end

end
