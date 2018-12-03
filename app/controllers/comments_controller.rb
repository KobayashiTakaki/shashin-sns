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

  end

end
