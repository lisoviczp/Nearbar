class HomeControllerController < ApplicationController
  def index
  	@current_user = User.first

  	if @current_user.establishments
  		@user_establishments = @current_user.establishments
  	end

  	
  end
end
