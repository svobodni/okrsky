class TownHall < ActiveRecord::Base

  belongs_to :municipality
  delegate :region, to: :municipality
  has_many :commisaries

  def taken_wards_numbers
  	commisaries.collect(&:ward_number)
  end

  def taken_wards_count
  	commisaries.size
  end

  def heraldry_path
  	"http://vdp.cuzk.cz/vdp/ruian/obce/#{municipality.id}/znak"
  end

  def flag_path
    "http://vdp.cuzk.cz/vdp/ruian/obce/#{municipality.id}/vlajka"
  end

end
