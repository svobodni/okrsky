class EventsController < ApplicationController

  def index
    @event=Event.new()
    @events = Event.accessible_by(current_ability)
    if params[:event]
      @event=Event.new(name: params[:event][:name], eventable_id: params[:event][:eventable_id])
      @events = @events.where(eventable_id: params[:event][:eventable_id]) unless params[:event][:eventable_id].blank?
      @events = @events.where(name: params[:event][:name]) unless params[:event][:name].blank?
    end
    @events = @events.order('created_at DESC') #.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @event = Event.find(params[:id])
  end

end
