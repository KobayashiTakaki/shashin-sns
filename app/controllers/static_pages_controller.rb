class StaticPagesController < ApplicationController
  def home
    @feed_items = Article.all
  end
end
