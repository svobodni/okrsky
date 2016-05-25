# encoding: utf-8
class Commisary < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  belongs_to :user
  belongs_to :town_hall
  has_many :events, as: :eventable

  validates :name, length: { minimum: 5 }
  validates :birth_number, length: { minimum: 8 }
  validates :address, length: { minimum: 12 }
  # validates :email, presence: true, length: { minimum: 5 }
  validates :ward, presence: true, uniqueness: true

  belongs_to :ward

  after_create :send_confirmation_email

  attr_accessor :region_id, :municipality_id, :district_id

  def send_confirmation_email
    CommisaryMailer.signup_confirmation(self).deliver
  end

  def shipping_address
  	postal_address.blank? ? address : postal_address
  end

  def password_required?
    false
  end

  def self.send_final_emails
    errors=[]
    all.order(:id).each{|commisary|
      begin
        CommisaryMailer.final(commisary).deliver
        puts "#{commisary.id} delivered"
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        puts "Mail for #{commisary.email} (#{commisary.id}) could not be sent"
        errors << commisary.id
      end
    }
    errors
  end

  attr_accessor :municipality_id, :region_id, :district_id

  def town_hall
    ward.try(:town_hall)
  end

  def district
    ward.try(:district)
  end

  def municipality
    town_hall.try(:municipality)
  end

  def region
    municipality.try(:region)
  end

end
