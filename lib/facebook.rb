class Facebook
  def self.access_token_info(access_token)
    Koala::Facebook::API.new.debug_token(access_token)
  end

  def self.user_hash(access_token)
    Koala::Facebook::API.new(access_token).get_object("me")
  end
end
