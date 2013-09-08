class ExportsController < ApplicationController
  def index
    if params[:password]=="h7Hd71"
      @town_halls=Commisary.all.group_by{|c| c.town_hall}
      if params[:region_id]
        @town_halls.reject!{|t,c| t.region.id!=params[:region_id].to_i}
      end
    else
      render :text=>"Auth fail"
    end    
  end
end
