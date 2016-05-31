class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  devise_group :person, contains: [:user, :commisary]

  def after_sign_in_path_for(resource)
    if current_user
      commisaries_path
    else
      commisary_path(current_commisary)
    end
  end

  def default_event_params
    {
      requestor_id: current_person.id,
      requestor_type: current_person.class.to_s,
      params: params,
      controller_path: controller_path,
      action_name: action_name,
      remote_ip: request.remote_ip,
      referer: request.referer
    }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_person)
  end
end
