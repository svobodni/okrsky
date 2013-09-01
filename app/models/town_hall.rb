class TownHall < ActiveRecord::Base

  belongs_to :municipality
  has_many :commisaries

end
