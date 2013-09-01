# encoding: utf-8
class Commisary < ActiveRecord::Base

  belongs_to :town_hall

  validates :name, length: { minimum: 5 }
  validates :birth_number, length: { minimum: 9 }, uniqueness: true
  validates :address, length: { minimum: 12 }
  validates :email, presence: true, length: { minimum: 5 }
  validates :town_hall, presence: true
  validates :ward_number, uniqueness: { scope: :town_hall, message: "okrsek je již obsazen" }, unless: "ward_number.empty?"
end
