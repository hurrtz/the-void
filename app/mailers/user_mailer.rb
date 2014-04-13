class UserMailer < ActionMailer::Base
  default from: "noreply@the-void.de"

  def activate_email(user)
    @user = user
    @key  = @user.activatekey

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
