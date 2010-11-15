class UserMailer < ActionMailer::Base
  default :from => "fabian.englaender@enterat.de"
  def signup_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Confirmation Request")
  end
end
