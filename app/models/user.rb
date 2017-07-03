class User < ApplicationRecord

  validates :token, presence: true

  after_initialize do |user|
    user.token ||= generate_unique_token
  end

  def self.from_code(code)
    access_token = Facebook.access_token(code)
    user_hash = Facebook.user_hash(access_token)

    user = User.find_or_create_by!(uid: user_hash["id"])
    user.update!(
      name: user_hash["name"],
      oauth_token: access_token,
    )
    user
  end

  private

  def generate_unique_token
    loop do
      token = SecureRandom.hex
      break token unless User.exists?(token: token)
    end
  end
end
