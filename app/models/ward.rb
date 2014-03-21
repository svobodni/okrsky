class Ward < ActiveRecord::Base
  belongs_to :district
  belongs_to :municipality
  has_one :commisary

  def taken?
    commisary ? true : false
  end

  def town_hall
    if district
      district.town_hall
    else
      municipality.town_hall
    end
  end

end
