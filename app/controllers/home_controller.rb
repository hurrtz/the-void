class HomeController < ApplicationController
  def index
    if params[:button] == 'register'
      _errors = []

      # check for submitted nick
      _errors.push('Bitte geben Sie einen Benutzernamen ein!') if params[:nick].empty?

      # check for submitted email
      _errors.push('Bitte geben Sie eine E-Mail-Adresse ein!') if params[:email].empty?

      # check for correct email
      _errors.push('Bitte geben Sie eine gültige E-Mail-Adresse ein!') if (params[:email] !~ %r{^.+@.+\..+$}xi)

      # check if email is already taken
      _errors.push('Die E-Mail-Adresse ist bereits vergeben.') if (User.where('email = ?', params[:email]).any?)

      if _errors.length > 0
        redirect_to '/', :flash => {:danger => _errors.join(' ')}
      else
        _password = Password::make
        Rails.logger.debug '===================='
        Rails.logger.debug 'neu erstelltes Originalpasswort'
        Rails.logger.debug _password
        Rails.logger.debug '===================='
        @user = User.new
        @user.first_fill(params[:nick], params[:email], Password::encrypt(_password))

        if @user.save
          UserMailer.activate_email(@user, _password).deliver
          redirect_to '/', :flash => {:success => 'Erster Schritt der Registrierung erfolgreich. Ihnen wurde eine E-Mail mit den Zugangsdaten zugesandt. Bitte schließen den Registrierungsprozess ab, indem Sie über den in der E-Mail enthaltenen Link die Gültigkeit Ihrer E-Mail-Adresse bestätigen.'}
        else
          redirect_to '/', :flash => {:danger => 'Bei der Registrierung ist ein Fehler aufgetreten. Sollte der Fehler weiterhin bestehen, wenden Sie sich bitte an the-void.'}
        end
      end
    elsif params[:button] == 'login' || params[:activate]
      # User hat auf den Aktivierungslink geklickt
      if params[:activate]
        user = User.find_by_activatekey(params[:activate])

        if user
          user.update_attributes(activatekey: '', active: true, loginfirst: DateTime.now, loginrecent: DateTime.now)

          cookies.signed[:user] = user.id
          cookies.signed[:password] = Password::encrypt(user.password)

          redirect_to '/local/overview', :flash => {:success => 'Gratulation! Das Spielerkonto ist nun aktiv! Viel Spaß bei the-void!'}
        else
          redirect_to '/', :flash => {:danger => 'Da hat etwas nicht geklappt... Der Aktivierungskey kann nicht in der Datenbank gefunden werden.'}
        end
      end

      # Login
      if params[:button] == 'login'
        # if the user needs a new password
        if params[:forgotten] == '1'
          user = User.where('email = ?', params[:email])

          if user.any?
            user = user.take
            _password = Password::make
            user.password = Password::encrypt(_password)
            user.update_attributes(password: Password::encrypt(_password), active: false, activatekey: user.make_activation_code)
            user.reload

            if user.save
              UserMailer.new_password(user, _password).deliver
              redirect_to '/', :flash => {:success => 'Ihr Passwort wurde zurückgesetzt und Ihnen erneut zugesandt. Bitte aktivieren Sie Ihr Konto über die E-Mail erneut.'}
            end

          else
            redirect_to '/', :flash => {:danger=> 'E-Mail-Adresse nicht bekannt.'}
          end
        else
          user = User.where('email = ? AND active = ?', params[:email], true)

          if user.any?
            user = user.take

            if Password::is_correct?(user.password, params[:password])
              user.update_attributes(loginrecent: DateTime.now)

              if params[:remember] == '1'
                cookies.permanent.signed[:user] = user.id
                cookies.permanent.signed[:password] = user.password
              else
                cookies.signed[:user] = user.id
                cookies.signed[:password] = user.password
              end

              redirect_to '/local/overview'
            else
              redirect_to '/', :flash => {:danger=> 'Login nicht möglich.'}
            end
          else
            redirect_to '/', :flash => {:danger=> 'Login nicht möglich.'}
          end
        end
      end
    end
  end
end
