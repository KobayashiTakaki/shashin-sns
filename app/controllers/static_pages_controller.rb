class StaticPagesController < ApplicationController
  def home
    if current_user
      if current_user.following.empty?
        @feed_items = Article.order("created_at DESC").page(params[:page]).per(20)
      else
        @feed_items = current_user.feed.order("created_at DESC").page(params[:page]).per(20)
      end
    end
  end
end
