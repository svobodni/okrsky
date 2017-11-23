# encoding: utf-8
class CommisaryMailer < ApplicationMailer
  def signup_confirmation(commisary)
    @commisary=commisary
    mail(
      to: commisary.email,
      subject: "[PR2017-OVK#{commisary.id}] Potvrzení přijetí registrace člena okrskové volební komise"
    )
  end
  def update_confirmation(commisary)
    @commisary=commisary
    mail(
      to: commisary.email,
      subject: "[PR2017-OVK#{commisary.id}] Potvrzení opravy registrace člena okrskové volební komise"
    )
  end
  def destroy_confirmation(commisary)
    @commisary=commisary
    mail(
      to: commisary.email,
      subject: "[PR2017-OVK#{commisary.id}] Potvrzení zrušení registrace člena okrskové volební komise"
    )
  end
end
