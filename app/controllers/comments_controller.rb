class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @comment = current_user.comments.build(comment_params)
    @review = Review.find(@comment.review_id)
    if @comment.save
      flash[:success] = "Commented!"
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @review = @comment.review
    @comment.destroy
    flash[:success] = "Comment Deleted"
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :review_id, :user_id)
  end
end
