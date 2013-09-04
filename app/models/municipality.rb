class Municipality < ActiveRecord::Base

  belongs_to :region
  has_many :districts
  has_one :town_hall
  has_many :town_halls, through: :districts

  default_scope { order("#{self.table_name}.name ASC") }

end
