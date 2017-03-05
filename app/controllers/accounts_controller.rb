class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    client ||= Restforce.new :oauth_token => current_user.oauth_token,
      :refresh_token           => current_user.refresh_token,
      :instance_url            => current_user.instance_url,
      :client_id               => ENV["SALESFORCE_CLIENT_ID"],
      :client_secret           => ENV["SALESFORCE_CLIENT_SECRET"],
      :authentication_callback => Proc.new {|x| Rails.logger.debug x.to_s}
    @accounts = client.query("select Id, Name, Website, Phone from Account limit 5")
  end
end
