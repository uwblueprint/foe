class Facebook
  def self.access_token(code)
    Koala::Facebook::OAuth.new.get_access_token(code)
  end

  def self.user_hash(access_token)
    Koala::Facebook::API.new(access_token).get_object("me")
  end
end
