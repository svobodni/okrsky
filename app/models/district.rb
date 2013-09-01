class District < ActiveRecord::Base

  belongs_to :municipality
  has_one :town_hall

end
