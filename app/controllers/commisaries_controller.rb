class CommisariesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :authenticate_person!, except: :new
  before_action :set_commisary, only: [:show, :edit, :update]

  def new
    authorize! :create, Commisary
  end

  def edit
    authorize! :update, @commisary
  end

  def update
    respond_to do |format|
      if @commisary.update(commisary_params)
        @commisary.events.create(default_event_params.merge({
          command: "UpdateCommisary",
          name: "CommisaryUpdated",
          changes: @commisary.previous_changes
        }))
        format.html { redirect_to @commisary, notice: 'Registrace byla úspěšně opravena.' }
        format.json { render :show, status: :ok, location: @commisary }
      else
        format.html { render :edit }
        format.json { render json: @commisary.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @commisaries = Commisary.accessible_by(current_ability)
  end

  def show
  end

  def destroy
    if current_commisary
      current_commisary.destroy
      flash[:notice]='Vaše registrace byla zrušena.'
      Event.create(default_event_params.merge({
        command: "DeleteCommisary",
        name: "CommisaryDeleted",
        eventable_id: params[:id],
        eventable_type: "Commisary"
      }))
      redirect_to "/"
    else
      current_user.commisaries.find(params[:id]).destroy
      Event.create(default_event_params.merge({
        command: "DeleteCommisary",
        name: "CommisaryDeleted",
        eventable_id: params[:id],
        eventable_type: "Commisary"
      }))
      respond_to do |format|
        format.html { redirect_to commisaries_path, notice: 'Registrace byla zrušena.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_commisary
      if commisary_signed_in?
        @commisary = current_commisary
      else
        @commisary = current_user.commisaries.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commisary_params
      params.fetch(:commisary, {}).permit(:name, :birth_number, :address, :phone, :postal_address)
    end
end
