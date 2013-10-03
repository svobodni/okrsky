class SignupController < ApplicationController

  include Wicked::Wizard

  steps :region, :municipality, :district, :ward, :confirm

  def show
    case step
    when :region
      @regions = Region.all
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
      @commisary = Commisary.new(:town_hall_id=>@town_hall.id)
    end
    render_wizard
  end

  def update
    @town_hall = TownHall.find(params[:commisary][:town_hall_id])
    @commisary = @town_hall.commisaries.build(commisary_params)
    if !@town_hall.region.registration_ends_at.blank? && @town_hall.region.registration_ends_at < Time.now
      render(:text=>"Registrace jsou jiz uzavreny!")
    else
      render_wizard @commisary
    end
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def commisary_params
      params.require(:commisary).permit(:town_hall_id, :ward_number, :name, :birth_number, :address, :phone, :email, :postal_address)
    end

end
