class Region < ActiveRecord::Base

  has_many :municipalities

  def send_first_notification_email
    ChairmanMailer.first_notification(self).deliver
  end

end
