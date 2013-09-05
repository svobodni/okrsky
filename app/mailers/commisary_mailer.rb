# encoding: utf-8
class CommisaryMailer < ActionMailer::Base
  default from: "kubicek@svobodni.cz"

  def signup_confirmation(commisary)
    @commisary = commisary
    options = URI.encode_www_form({'entry.1968618813'=>commisary.email,
		'entry.74680682'   => commisary.name,
		'entry.917885295'  => commisary.shipping_address})
    @url = "https://docs.google.com/forms/d/1bkN-w1JgvpQpdM-0Os_Q-cjcbaOg_uR-NE1Tx_mc870/viewform?#{options}"

    mail(to: commisary.email, bcc: 'kubicek@svobodni.cz', subject: '[PSP2013-OVK#{@commisary.id}] Potvrzení přijetí registrace člena okrskové volební komise')
  end

end
