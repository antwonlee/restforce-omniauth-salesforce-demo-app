class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def salesforce
    # For testing the results
    # raise request.env["omniauth.auth"].to_yaml

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Salesforce") if is_navigational_format?
    else
      session["devise.salesforce_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
