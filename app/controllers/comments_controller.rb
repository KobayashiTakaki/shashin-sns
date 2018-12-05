class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    content = params[:comment][:content]
    @created_comment = current_user.comment(@article, content)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @destroyed_comment = Comment.find(params[:id])
    if @destroyed_comment.user == current_user
      @destroyed_comment.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end

end
