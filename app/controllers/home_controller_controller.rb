class HomeControllerController < ApplicationController
  def index
  	
  	# CHANGE THIS AFTER ADDING DEVISE
  	@current_user = User.first

  	if @current_user.establishments
  		@user_establishments = @current_user.establishments
  	end
    
  	@deals=Deal.all.order('updated_at DESC')
    @favorite_establishments = @current_user.favorites
    @favorite_deals = @current_user.favorited_deals
  	
  end
end
