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
      user.oauth_token = auth.credentials.token
      user.refresh_token = URI.unescape(auth.credentials.refresh_token)
      user.save!
    end
  end

  def restforce
    if oauth_token && refresh_token && instance_url
      @restforce ||= Restforce.new :oauth_token => oauth_token,
        :refresh_token           => refresh_token,
        :instance_url            => instance_url,
        :client_id               => ENV["SALESFORCE_CLIENT_ID"],
        :client_secret           => ENV["SALESFORCE_CLIENT_SECRET"],
        :authentication_callback => Proc.new {|x| Rails.logger.debug x.to_s}
    end
  end
end
