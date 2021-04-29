class DistrictTownHall < TownHall

  belongs_to :district, required: false
  delegate :municipality, to: :district, allow_nil: true

  has_many :wards, foreign_key: :district_id, primary_key: :district_id

  def heraldry_path
  	"http://vdp.cuzk.cz/vdp/ruian/mestskecasti/#{district.id}/znak"
  end

  def flag_path
    "http://vdp.cuzk.cz/vdp/ruian/mestskecasti/#{district.id}/vlajka"
  end

end
