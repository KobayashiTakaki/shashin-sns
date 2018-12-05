class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @article = Article.find(params[:article_id])
    current_user.like(@article)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    current_user.unlike(@article)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

end
