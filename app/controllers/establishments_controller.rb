class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # @establishments = Establishment.all
    # respond_with(@establishments)
    if params[:search]
      @establishments = Establishment.search(params[:search])
    else
      @establishments = Establishment.all
    end
    @current_user=User.first
  end

  def show
    # Only will show deals that are active
    @current_deals = Deal.all.where(establishment_id: @establishment, temporary: true, active: true)
    @permanent_deals = Deal.all.where(establishment_id: @establishment, temporary: false, active: true)
    @current_user=User.first
    
    # pry
    respond_with(@establishment)
  end

  def new
    @establishment = Establishment.new
    respond_with(@establishment)
  end

  def edit
  end

  def favorite
    type = params[:type]
    @establishment=Establishment.find(params[:id])
    @current_user=User.first
    if type == "favorite" and ! @current_user.favorites.include? @establishment
      # pry
      # @current_user=User.first
      @current_user.favorites << @establishment
      redirect_to :back, notice: "You favorited #{@establishment.name}"

    elsif type == "unfavorite"
      @current_user.favorites.delete(@establishment)
      redirect_to :back, notice: "Unfavorited #{@establishment.name}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: "You've already favorited #{@establishment.name}."
    end
  end


  def favorites_page
    @current_user = User.first
    @establishments = @current_user.favorites
    respond_with(@establishments)
  end

  def your_establishments
    @current_user = User.first
    @establishments = Establishment.where(user_id: @current_user)
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
      params.require(:establishment).permit(:name, :address, :city, :state, :zipcode, :email, :key, :user_id, deals: [])
    end
end
