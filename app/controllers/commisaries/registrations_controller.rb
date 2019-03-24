class Commisaries::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_filter :require_no_authentication, :only => [ :new, :create ]

  def new
    permitted = params.require(:commisary).permit(:ward_id)
    @commisary=Commisary.new(permitted)
    ward=Ward.find_by_id(@commisary.ward_id)
    if ward.nil?
      flash[:error] = "Neznámý okrsek, vyberte prosím znovu"
      redirect_to new_commisary_path
    elsif ward.taken?
      flash.now[:error] = "Tento okrsek je již obsazený"
    end
    #super
  end

  # POST /resource
  def create
    params[:commisary][:user_id]=current_user.try(:id)
    password=Devise.friendly_token.first(8)
    params[:commisary][:password]=password
    params[:commisary][:password_confirmation]=password
    build_resource(sign_up_params)

    authorize! :create, resource
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.events.create(default_event_params.merge({
        command: "CreateCommisary",
        name: "CommisaryCreated",
        changes: resource.previous_changes
      }))
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birth_number, :address, :postal_address, :phone, :email, :region_id, :municipality_id, :district_id, :ward_id, :user_id, :party_member, :party_voter])
  end

end
