class UserMailer < ActionMailer::Base
  default from: "noreply@the-void.de"

  def activate_email(user, password)
    @user = user
    @key  = @user.activatekey
    @password = password

    mail(to: @user.email, subject: 'Registrierung auf the-void.de')
  end
end
