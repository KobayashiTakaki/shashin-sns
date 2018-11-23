class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  def destroy
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :password, :password_confirmation
      )
    end
end
