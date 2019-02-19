class ArticlesController < ApplicationController
  before_action :logged_in_user, except: [:show]

  def new
    @article = Article.new()
  end

  def create
    article = current_user.articles.build(article_params)
    if article.save
      flash[:success] = "画像を投稿しました"
      redirect_to root_url
    else
      flash[:danger] = "画像の投稿に失敗しました"
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  def update
    @article = Article.find(params[:id])
  end

  def comments
    @page = params[:page]
    @article = Article.find(params[:id])
    @comments = @article.comments.order("created_at DESC").page(@page).per(10).reverse
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  private
    def article_params
      params.require(:article).permit(:picture)
    end
end
