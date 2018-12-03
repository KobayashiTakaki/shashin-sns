class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    content = params[:comment][:content]
    @created_comment = current_user.comment(@post, content)
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
