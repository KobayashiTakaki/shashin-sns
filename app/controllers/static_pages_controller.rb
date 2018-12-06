class StaticPagesController < ApplicationController
  def home
    if current_user.following.empty?
      @feed_items = Article.order("created_at DESC").page(1).per(20)
    else
      @feed_items = current_user.feed.order("created_at DESC").page(1).per(20)
    end
  end
end
