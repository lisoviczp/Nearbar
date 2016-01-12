class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @establishments = Establishment.all
    respond_with(@establishments)
  end

  def show
    @current_deals = Deal.all.where(establishment_id: @establishment, current: true)
    @permanent_deals = Deal.all.where(establishment_id: @establishment, permanent: true)
    # pry
    respond_with(@establishment)
  end

  def new
    @establishment = Establishment.new
    respond_with(@establishment)
  end

  def edit
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.save
    respond_with(@establishment)
  end

  def update
    @establishment.update(establishment_params)
    respond_with(@establishment)
  end

  def destroy
    @establishment.destroy
    respond_with(@establishment)
  end

  private
    def set_establishment
      @establishment = Establishment.find(params[:id])
    end

    def establishment_params
      params.require(:establishment).permit(:name, :address, :city, :state, :zipcode, :email, :key, deals: [])
    end
end
