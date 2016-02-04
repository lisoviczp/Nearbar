class HomeController < ApplicationController

  def index
    if current_user
    	if current_user.establishments
    		@user_establishments = current_user.establishments
    	end

    	@deals=Deal.all.order('updated_at DESC')
      @favorite_establishments = current_user.favorites
      @favorite_deals = current_user.favorited_deals
    else 
      @deals=Deal.all.order('updated_at DESC')
    end
  end

  def info
    puts
  end

end
