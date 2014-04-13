class HomeController < ApplicationController
  def index
    if params && params[:nick] && params[:email]
      _errors = []

      # check for submitted nick
      _errors.push('Bitte geben Sie einen Benutzernamen ein!') if params[:nick].empty?

      # check for correct email
      _errors.push('Bitte geben Sie eine gültige E-Mail-Adresse ein!') if (params[:email] !~ %r{^.+?@.+?\..{2,5}$}xi)

      if _errors.length > 0
        redirect_to '/', :flash => {:danger => _errors.join(' ')}
      else
        @user = User.new
        @user.first_fill(params[:nick], params[:email])

        if @user.save
          UserMailer.activate_email(@user).deliver
          redirect_to '/', :flash => {:success => 'Erster Schritt der Registrierung erfolgreich. Ihnen wurde eine E-Mail mit den Zugangsdaten zugesandt. Bitte schließen den Registrierungsprozess ab, indem Sie über den in der E-Mail enthaltenen Link die Gültigkeit Ihrer E-Mail-Adresse bestätigen.'}
        else
          redirect_to '/', :flash => {:danger => 'Bei der Registrierung ist ein Fehler aufgetreten. Sollte der Fehler weiterhin bestehen, wenden Sie sich bitte an the-void.'}
        end
      end
    elsif params && (params[:login] || params[:activate])
      # User hat auf den Aktivierungslink geklickt
      if params[:activate]
        user = User.where(activatekey: params[:activate])

        if user.any?
          user = user.take!
          user.update_attributes(activatekey: '', active: true, firstlogin: DateTime.now, lastlogin: DateTime.now)
          redirect_to '/local/overview', :flash => {:success => 'Gratulation! Die Registrierung ist abgeschlossen. Viel Spaß bei the-void!'}
        else
          redirect_to '/', :flash => {:danger=> 'Da hat etwas nicht geklappt... Der Aktivierungskey kann nicht in der Datenbank gefunden werden.'}
        end
      end

      if params[:remember] == '1'
        cookies.permanent[:nick] = :nick
        cookies.permanent[:email] = :email
      end

      if params[:login] && params[:authentication]
        user = User.where("authentification = ? AND active = ?", params[:authentication], true)

        if user.any?
          user = user.take!
          user.update_attributes(lastlogin: DateTime.now)
          redirect_to '/local/overview'
        else
          redirect_to '/', :flash => {:danger=> 'Login nicht möglich.'}
        end
      end
    end
  end
end
