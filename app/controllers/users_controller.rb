class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]

  def index
    @users = User.all
  end

  def index_liked_to_article
    article_id = params[:article_id] || nil
    @users = User.joins(:likes).where("article_id = ?", article_id)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
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

  def show
    @user = User.find_by(name: params[:user_name])
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
      log_in @user
      sign_in(@user, :bypass => true)
      flash[:success] = "保存しました"
      redirect_to "/#{@user.name}"
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
        :name, :email, :display_name, :picture,
        :password, :password_confirmation
      )
    end
end
