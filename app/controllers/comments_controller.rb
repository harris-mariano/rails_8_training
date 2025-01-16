class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [ :create, :destroy ]
  before_action :set_comment, only: [ :destroy ]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      redirect_to @article, alert: "Comment could not be saved."
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
