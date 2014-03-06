class StatsController < ApplicationController
  def index
    @stats = Commisary.all.group_by{|c| c.ward.town_hall.region}
  end
end
