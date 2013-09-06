class StatsController < ApplicationController
  def index
    @stats = Commisary.all.group_by{|c| c.town_hall.region}
  end
end
