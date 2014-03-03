class SignupController < ApplicationController

  include Wicked::Wizard

  steps :region, :municipality, :district, :ward, :commisary, :confirm

  def show
    case step
    when :region
      @regions = Region.all
      redirect_to(wizard_path(:municipality, region_id: @regions.first.id)) and return nil if @regions.count==1
    when :municipality
      @municipalities = Region.find(params[:region_id]).municipalities
      redirect_to(wizard_path(:district, municipality_id: 554782)) and return nil if params[:region_id].to_i==19 # kraj Praha == obec Praha
    when :district
      @districts = Municipality.find(params[:municipality_id]).districts
      redirect_to(wizard_path(:ward, municipality_id: params[:municipality_id])) and return nil if @districts.empty?
    when :ward
      unless params[:district_id].nil?
        @town_hall = District.find(params[:district_id]).town_hall
      else
        @town_hall = Municipality.find(params[:municipality_id]).town_hall
      end
    when :commisary
      @commisary = Commisary.new(:ward_id=>params[:ward_id])
    end
    render_wizard
  end

  def update
    @commisary = Commisary.new(commisary_params)
    if !@commisary.ward.town_hall.region.registration_ends_at.blank? && @commisary.ward.town_hall.region.registration_ends_at < Time.now
      render(:text=>"Registrace jsou již uzavřeny!")
    else
      render_wizard @commisary
    end
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def commisary_params
      params.require(:commisary).permit(:ward_id, :name, :birth_number, :address, :phone, :email, :postal_address)
    end

end
