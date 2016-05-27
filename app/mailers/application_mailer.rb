class ApplicationMailer < ActionMailer::Base
  default from: configatron.our_email,
          bcc: configatron.admin_email
  layout 'mailer'
end
