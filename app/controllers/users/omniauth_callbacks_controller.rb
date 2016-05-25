class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def registr
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Registr") if is_navigational_format?
    else
      session["devise.registr_data"] = request.env["omniauth.auth"]
      redirect_to "/"
    end
  end

  def failure
    redirect_to root_path
  end

end
