class User < ApplicationRecord
  validates :token, presence: true

  has_many :sightings

  after_initialize do |user|
    user.token ||= generate_unique_token
  end

  def self.from_code(access_token)
    # access token is validated but not persisted
    access_token_info = Facebook.access_token_info(access_token)
    user_hash = Facebook.user_hash(access_token)

    user = User.find_or_create_by!(uid: user_hash["id"])
    user.update!(
      name: user_hash["name"],
      # oauth_token: access_token,
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
