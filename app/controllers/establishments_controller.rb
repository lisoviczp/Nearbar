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

    @new_establishments = Establishment.where(
      'created_at >= :five_days_ago or updated_at >= :three_days_ago',
      :five_days_ago  => Time.now - 5.days,
      :three_days_ago => Time.now - 3.days
    )
    @featured_establishments = []
    # Threshold to be a featured deal is currently 0 favorites...
    Establishment.all.each do |establishment|
      if establishment.total_users_favorited >= 2
        @featured_establishments << establishment
      end
    end
  end

  def tests
    # @establishments = Establishment.all
    # respond_with(@establishments)
    if params[:search]
      @establishments = Establishment.search(params[:search])
    else
      @establishments = Establishment.all
    end

    @new_establishments = Establishment.where(
      'created_at >= :five_days_ago or updated_at >= :three_days_ago',
      :five_days_ago  => Time.now - 5.days,
      :three_days_ago => Time.now - 3.days
    )
    @featured_establishments = []
    # Threshold to be a featured deal is currently 0 favorites...
    Establishment.all.each do |establishment|
      if establishment.total_users_favorited >= 2
        @featured_establishments << establishment
      end
    end
  end

  def show
    # Only will show deals that are active
    @current_deals = Deal.all.where(establishment_id: @establishment, temporary: true, active: true)
    @permanent_deals = Deal.all.where(establishment_id: @establishment, temporary: false, active: true)

    # daily_email(@establishment)

    today=Time.now.strftime("%A")
    @todays_deals = Deal.where(establishment_id: @establishment, weekday: ['Today', today])

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

    if type == "favorite" and ! current_user.favorites.include? @establishment
      current_user.favorites << @establishment
      redirect_to :back, notice: "You favorited #{@establishment.name}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@establishment)
      redirect_to :back, notice: "Unfavorited #{@establishment.name}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: "You've already favorited #{@establishment.name}."
    end
  end


  def favorites_page
    if user_signed_in?
      @establishments = current_user.favorites
      respond_with(@establishments)
    else
      redirect_to establishments_path
    end

  end

  def your_establishments
    @establishments = Establishment.where(user: current_user)
  end


  def weekly_email
    puts "Sending weekly email"
    EstablishmentMailer.weekly_email().deliver!
  end

  def daily_email(estab)

    @establishment = estab
    users_to_email = @establishment.favorited_by
    @specials = "This is where we list the specials!"

    # uncomment this to send to all users that favorited the establishment
    # users_to_email.each do |user|
    #   # puts "Sending daily email to #{user}"
    #   EstablishmentMailer.daily_email(specials).deliver!
    # end

    EstablishmentMailer.daily_email(@specials).deliver!
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.user = current_user
    @establishment.save

    # daily_email

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
      params.require(:establishment).permit(:name, :address, :city, :state, :zipcode, :email, :key, :drinks, :user_id, deals: [])
    end
end
