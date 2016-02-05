require 'twilio-ruby'

class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # @deals = Deal.all
    # respond_with(@deals)
    if params[:search]
      @deals = Deal.search(params[:search])
    else
      @deals = Deal.all.where(active: true)
    end

    @featured_deals = Deal.where(
      'created_at >= :three_days_ago or updated_at >= :one_day_ago',
      :three_days_ago  => Time.now - 3.days,
      :one_day_ago => Time.now - 1.days
    )

  end

  def show
    respond_with(@deal)
  end

  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  def send_text_message(receiving_number, new_deal_establishment, new_deal_message)
    # number_to_send_to = params[:number_to_send_to]
    
    number_to_send_to = receiving_number
    # number_to_send_to='9738680162'

    # Creating message to send
    new_message = new_deal_establishment += ': '
    new_message +='$1 BEERS AT GYMBAR - NOW TILL CLOSE!!!!'

    twilio_sid=ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_TOKEN']
    twilio_phone_number = "2016853575"

    puts "Twilio stuff: "
    puts twilio_sid
    puts twilio_token

    puts "Text Message Info: "
    puts number_to_send_to, new_message


    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    # Uncomment this to send it
    # @twilio_client.account.sms.messages.create(
    #   :from => "+1#{twilio_phone_number}",
    #   :to => number_to_send_to,
    #   :body => new_message
    # )
  end


  def edit
  end

  def favorite
    type = params[:type]
    @deal=Deal.find(params[:id])
    if type == "favorite" and ! current_user.favorited_deals.include? @deal
      # pry
      # @current_user=User.first
      current_user.favorited_deals << @deal
      redirect_to :back, notice: "You favorited #{@deal.keyword}"

    elsif type == "unfavorite"
      current_user.favorited_deals.delete(@deal)
      redirect_to :back, notice: "Unfavorited #{@deal.keyword}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: "You've already favorited #{@deal.keyword}."
    end
  end

  def favorite_deals_page
    @deals = current_user.favorited_deals
    respond_with(@deals)
  end

  def create
    @deal = Deal.new(deal_params)

    if @deal.save
      new_message = @deal.description
      new_establishment = @deal.establishment

      # Send the new deal message to each user that had favorited the establishment
      puts "These are the users who favorited #{new_establishment}"
      for each_user in new_establishment.favorited_by
        puts each_user
        # send_text_message(each_user.phone_number, new_establishment, new_message)
      end
    end

    respond_with(@deal)
  end

  def update
    @deal.update(deal_params)
    @deal.save
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
      params.require(:deal).permit(:keyword, :description, :temporary, :permanent, :establishment_id, :active, :weekday)
    end
end
