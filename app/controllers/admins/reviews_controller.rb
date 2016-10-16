class Admins::ReviewsController < ApplicationController
  before_action :require_admin
  before_action :load_review, except: [:index, :new, :create]

  def index
    @reviews = Review.order(sort_column + " " + sort_direction).page(params[:page]).per 10
  end

  def show
    @review = Review.find_by_id params[:id]
    @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = "The review has been successfully created."
      redirect_to admins_reviews_path
    else
      flash.now[:danger] = "Failed to create the review."
      render "new"
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = "The review has been successfully updated."
      redirect_to admins_reviews_path
    else
      flash.now[:danger] = "Failed to edit the review."
      render "edit"
    end
  end

  def destroy
    if @review.nil?
      flash[:danger] = "The review does not exist."
    else
      @review.destroy
      flash[:success] = "The review has been deleted."
    end
    redirect_to admins_reviews_path
  end

  private
  def load_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit :title, :content, :device_id
  end

  def sort_column
    Review.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end