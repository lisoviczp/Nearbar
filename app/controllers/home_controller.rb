class HomeController < ApplicationController

  def index

    if user_signed_in?
    	if current_user.establishments
    		@user_establishments = current_user.establishments
    	end

    	@deals=Deal.all.order('updated_at DESC')
      @favorite_establishments = current_user.favorites
      @favorite_deals = current_user.favorited_deals

      today=Time.now.strftime("%A")

      @todays_deals=Deal.where(:weekday=>[today,"Today"])

      # urrent_user.comments.where(:id=>[123,"456","Michael Jackson"])

    else 
      redirect_to deals_path
      @deals=Deal.all.order('updated_at DESC')
    end
  end

  def info
    puts
  end

end
