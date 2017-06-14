class User < ApplicationRecord

  validates :oauth_token, :token, presence: true

  after_initialize do |user|
    user.token ||= generate_unique_token
  end

  private

  def generate_unique_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(token: token)
    end
  end
end
