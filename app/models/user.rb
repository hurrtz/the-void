class User < ActiveRecord::Base
  # sets nick, email and the authentification string
  def first_fill(nick, email)
    # Zeichensatz für Passwort, 128 Zeichen
    _alphabet = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a  + %w(Ü ü Ö ö Ä ä α β Γ γ Δ δ Ε ε ζ η Θ θ ι κ Λ λ μ ν Ξ ξ o Π π ρ Σ σ τ υ Φ φ χ Ψ ψ Ω ω Б б в г Д д Ж ж И и к Л л м н о п т ф Ч ч Э э Я я)

    # durchmische das erstellte Array zufällig
    _alphabet.shuffle!

    self.authentification = ''

    # bei einem Passwort von 64 Zeichen Länge und 128 möglichen Varianten je Zeichen ergibt sich:
    # 128^64 => 726.838.724.295.606.890.549.323.807.888.004.534.353.641.360.687.318.060.281.490.199.180.639.288.113.397.923.326.191.050.713.763.565.560.762.521.606.266.177.933.534.601.628.614.656 Kombinationsmöglichkeiten für das Passwort
    # 128^64 => 162 Nullen...
    0.upto(63) do |i|
      self.authentification += _alphabet[Random.rand(0...128)].to_s
    end

    # Zeichensatz für den einmaligen Aktivierungskey, 62 Zeichen
    _alphabet = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a

    # durchmische das erstellte Array zufällig
    _alphabet.shuffle!

    # den einmaligen Registrierungskey bauen
    self.activatekey = ''

    0.upto(31) do |i|
      self.activatekey += _alphabet[Random.rand(0...62)].to_s
    end

    self.nick = nick
    self.email = email
    self.active = false
    self.firstlogin = nil
    self.lastlogin = nil
    self.created_at = DateTime.now
    self.updated_at = nil

    self
  end

  def to_s
    "nick: #{@nick}\r\nemail: #{@email}\r\nauthentification: #{@authentification}\r\nactive: #{@active}\r\nfirstlogin: #{@firstlogin}\r\nlastlogin: #{@lastlogin}\r\ncreated_at: #{@created_at}\r\nupdated_at: #{@updated_at}"
  end
end
