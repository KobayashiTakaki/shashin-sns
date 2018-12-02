class CommentsController < ApplicationController

  def index
    per_page = params[:per_page] || 3
    page = params[:page] || 1
    @comments = Comment.per(per_page).page(page)
  end

  def create
    post = Post.find(params[:post_id])
    content = params[:comment][:content]
    current_user.comment(post, content)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy

  end
end
