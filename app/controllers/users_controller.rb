class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

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
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "保存しました"
      redirect_to root_url
    else
      flash.now[:danger] = "保存に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :display_name, :password, :password_confirmation
      )
    end
end
