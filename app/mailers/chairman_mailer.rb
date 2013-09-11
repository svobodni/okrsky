# encoding: utf-8
class ChairmanMailer < ActionMailer::Base
  default from: "kubicek@svobodni.cz"

  def first_notification(region)
    @region = region
    mail(to: region.chairman_email, bcc: 'kubicek@svobodni.cz', subject: "Delegace do okrskových volebních komisí - žádost o součinnost")
  end

end
