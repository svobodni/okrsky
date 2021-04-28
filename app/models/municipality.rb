class Municipality < ApplicationRecord

  belongs_to :region
  has_many :districts
  has_one :town_hall
  has_many :town_halls, through: :districts
  has_many :wards

  scope :allowed, -> { where(registration_allowed: 't') }

  default_scope { order("#{self.table_name}.name ASC") }

end
