class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # @deals = Deal.all
    # respond_with(@deals)
    if params[:search]
      @deals = Deal.search(params[:search])
    else
      @deals = Deal.all
    end
    @current_user = User.first

  end

  def show
    @current_user = User.first
    respond_with(@deal)
  end

  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  def edit
  end

  def favorite
    type = params[:type]
    @deal=Deal.find(params[:id])
    @current_user=User.first
    if type == "favorite" and ! @current_user.favorited_deals.include? @deal
      # pry
      # @current_user=User.first
      @current_user.favorited_deals << @deal
      redirect_to :back, notice: "You favorited #{@deal.keyword}"

    elsif type == "unfavorite"
      @current_user.favorited_deals.delete(@deal)
      redirect_to :back, notice: "Unfavorited #{@deal.keyword}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: "You've already favorited #{@deal.keyword}."
    end
  end

  def favorite_deals_page
    @current_user = User.first
    @deals = @current_user.favorited_deals
    respond_with(@deals)
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.save
    respond_with(@deal)
  end

  def update
    @deal.update(deal_params)
    respond_with(@deal)
  end

  def destroy
    @deal.destroy
    respond_with(@deal)
  end

  private
    def set_deal
      @deal = Deal.find(params[:id])
    end

    def deal_params
      params.require(:deal).permit(:keyword, :description, :current, :permanent, :establishment_id, :active)
    end
end
