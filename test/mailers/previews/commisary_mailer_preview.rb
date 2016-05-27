# Preview all emails at http://localhost:3000/rails/mailers/commisary_mailer
class CommisaryMailerPreview < ActionMailer::Preview
  def signup_confirmation
    CommisaryMailer.signup_confirmation(Commisary.first)
  end
  def update_confirmation
    CommisaryMailer.update_confirmation(Commisary.first)
  end
  def destroy_confirmation
    CommisaryMailer.destroy_confirmation(Commisary.first)
  end
end
