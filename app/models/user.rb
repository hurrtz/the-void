class User < ActiveRecord::Base
  def first_fill(nick, email, password)
    self.onick = nick
    self.nick = unique_nick
    self.email = email
    self.password = password
    self.active = false
    self.activatekey = make_activation_code
    self.loginrecent = nil
    self.loginfirst = nil
    self.created = DateTime.now

    self
  end

  def unique_nick
    i = 0
    nick = self.onick

    # den Nick erweitern, wenn er schon vergeben sein sollte
    # Query in Schleife, aber diese Rotze kommt je User ja nur einmal vor...
    while User.where('nick = ? OR onick = ?', nick, nick).any?
      i += 1
      nick = self.onick.to_s + '#' + i.to_s
    end

    nick
  end

  def make_activation_code
    _length = 32

    # Zeichensatz für den einmaligen Aktivierungskey, 62 Zeichen
    _alphabet = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a

    # durchmische das erstellte Array zufällig
    _alphabet.shuffle!

    # den einmaligen Registrierungskey bauen
    _activatekey = ''

    0.upto(_length) do |i|
      _activatekey += _alphabet[Random.rand(0..._alphabet.length)].to_s
    end

    _activatekey
  end
end
