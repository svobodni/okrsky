class ExportsController < ApplicationController
  def index
    region = Region.find(params[:region_id])
    authorize! :letter, region
    @town_halls=Commisary.all.group_by{|c| c.ward.town_hall}
    @town_halls.reject!{|t,c| t.region.id!=params[:region_id].to_i}
  end

  # def regions
  #   @regions = Region.all
  # end
  #
  # def municipalities
  #   @municipalities = Municipality.all
  # end
  #
  # def wards
  #   @wards = Ward.includes(:commisary, :municipality)
  # end

end
