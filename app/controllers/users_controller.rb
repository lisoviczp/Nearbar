class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # redirect_to root_path
    # @users = User.all
    # respond_with(@users)
  end

  def show
    # redirect_to root_path
    
    respond_with(@user)
  end

  def new
    redirect_to root_path
    # @user = User.new
    # respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :address, :city, :state, :zipcode, establishments: [])
    end
end
