class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.instance_url = auth.credentials.instance_url
      user.oauth_token = URI.uneescape(auth.credentials.token)
      user.refresh_token = URI.unescape(auth.credentials.refresh_token)
      user.save!
    end
  end
end
