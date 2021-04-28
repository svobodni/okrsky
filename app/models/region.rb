class Region < ApplicationRecord

  has_many :municipalities
  belongs_to :representative, class_name: 'User'

  def send_first_notification_email
    ChairmanMailer.first_notification(self).deliver
  end

end
