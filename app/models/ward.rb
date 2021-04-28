class Ward < ApplicationRecord
  belongs_to :district
  belongs_to :municipality
  has_one :commisary

  def taken?
    commisary ? true : false
  end

  def town_hall
    if district && ![556904,555321].member?(district_id) # Liberec, Opava
      district.town_hall
    else
      municipality.town_hall
    end
  end

  def name
    "#{self.external_id}" + (taken? ? " (obsazený)" : "")
  end
end
