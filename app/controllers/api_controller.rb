class ApiController < ApplicationController
  before_action :load_resources

  def municipalities
    @municipalities = @region ? @region.municipalities : Municipality.all
    @municipalities = @municipalities.where(registration_allowed: true)
    respond_to do |format|
      format.json { render json: @municipalities, only: [:id, :name] }
    end
  end

  def wards
    @wards = @municipality.districts.find_by_id(params[:district_id]).try(:wards) if params[:district_id]
    @wards ||= [] unless @municipality.districts.empty?
    @wards ||= @municipality.wards
    @wards ||= Ward.includes(:commisary)
    @wards = @wards.order(:external_id) if @wards.respond_to?(:order)
    respond_to do |format|
      format.json { render json: @wards, only: :id, methods: :name }
    end
  end

  def districts
    @districts = @municipality ? @municipality.districts : District.all
    respond_to do |format|
      format.json { render json: @districts, only: :id, methods: :name }
    end
  end

  private
  def load_resources
    @region=Region.find_by_id(params[:region_id]) if params[:region_id]
    @municipality=Municipality.find_by_id(params[:municipality_id]) if params[:municipality_id]
  end
end
