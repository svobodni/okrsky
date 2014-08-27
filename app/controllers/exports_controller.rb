class ExportsController < ApplicationController
  def index
    Municipality.includes(:wards).reject{|m| m.wards.detect{|w| !w.taken?}}

    region = Region.find(params[:region_id])
    if params[:password]==region.password
      @town_halls=Commisary.all.group_by{|c| c.ward.town_hall}
      if params[:region_id]
        @town_halls.reject!{|t,c| t.region.id!=params[:region_id].to_i}
      end
    else
      render :text=>"Auth fail"
    end
  end

  def senat
    Municipality.includes(:wards).reject{|m| m.wards.detect{|w| !w.taken?}}

    region = Region.find(params[:region_id])
    if params[:password]==region.password
      @town_halls=Commisary.all.group_by{|c| c.ward.town_hall}
      if params[:region_id]
        @town_halls.reject!{|t,c| t.region.id!=params[:region_id].to_i}
      end
    else
      render :text=>"Auth fail"
    end
  end

  def regions
    @regions = Region.all
  end

  def municipalities
    @municipalities = Municipality.all
  end

  def wards
    @wards = Ward.includes(:commisary, :municipality)
  end

end
