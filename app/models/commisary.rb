# encoding: utf-8
class Commisary < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  before_validation :fix_params

  belongs_to :user
  belongs_to :town_hall
  has_many :events, as: :eventable

  validates :name, length: { minimum: 5 }
  validates :birth_number, length: { minimum: 8 }
  validates :address, length: { minimum: 12 }
  validates :postal_address, length: { minimum: 12 }, allow_blank: true
  # validates :email, presence: true, length: { minimum: 5 }
  validates :ward, presence: true, uniqueness: true

  #validates :party_member, acceptance: true, acceptance: { message: 'nesmíte být členem jiné strany' }
  #validates :party_voter, acceptance: true, acceptance: { message: 'musíte volit Svobodné' }

  belongs_to :ward

  after_create :send_signup_confirmation_email
  after_update :send_update_confirmation_email
  before_destroy :send_destroy_confirmation_email

  attr_accessor :region_id, :municipality_id, :district_id

  def fix_params
    fix_birth_number
    fix_phone
  end

  def fix_birth_number
    parts = birth_number.match(/\A(\d{6})\/?(\d{3,4})\z/)
    if parts
      self.birth_number=[parts[1],parts[2]].join('/')
    end
  end

  def fix_phone
    self.phone = phone.gsub(/ /,'').match(/\A(\+420)?(.*)\z/)[2]
  end

  def send_signup_confirmation_email
    CommisaryMailer.signup_confirmation(self).deliver
  end

  def send_update_confirmation_email
    unless (%w(last_sign_in_at current_sign_in_at last_sign_in_ip current_sign_in_ip sign_in_count updated_at)-changed_attributes.keys).empty?
      CommisaryMailer.update_confirmation(self).deliver
    end
  end

  def send_destroy_confirmation_email
    CommisaryMailer.destroy_confirmation(self).deliver
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
  attr_accessor :party_member, :party_voter

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
