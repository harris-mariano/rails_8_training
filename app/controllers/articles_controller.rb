class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_article, only: [ :edit, :update, :show, :destroy ]

  def index
    # @articles = Article.all

    @q = Article.ransack(params[:q])
    @articles = @q.result.includes(:user).page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
