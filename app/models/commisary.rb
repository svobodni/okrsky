# encoding: utf-8
class Commisary < ActiveRecord::Base

  belongs_to :town_hall

  validates :name, length: { minimum: 5 }
  validates :birth_number, length: { minimum: 9 }, uniqueness: true
  validates :address, length: { minimum: 12 }
  validates :email, presence: true, length: { minimum: 5 }
  validates :ward, presence: true

  belongs_to :ward

  after_create :send_confirmation_email

  def send_confirmation_email
    CommisaryMailer.signup_confirmation(self).deliver
  end

  def shipping_address
  	postal_address.blank? ? address : postal_address
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

end
