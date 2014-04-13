json.array!(@users) do |user|
  json.extract! user, :id, :authentification, :nick, :email, :active, :firstlogin, :lastlogin
  json.url user_url(user, format: :json)
end
