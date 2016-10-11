class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_review, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.order(sort_column + " " + sort_direction).
      page(params[:page]).per 10
    @search = Review.search do
      fulltext params[:search]
    end
    @reviews = @search.results
  end

  def show
    @review = Review.find_by_id params[:id]
    impressionist @review
    @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:success] = "The review has been successfully created."
      redirect_to reviews_path
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
      redirect_to reviews_path
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
    redirect_to reviews_path
  end

  private
  def load_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit :title, :content, :device_id
  end

  def correct_user
    @review = current_user.reviews.find_by id: params[:id]
    if @review.nil?
      flash[:danger] = "You are not authorized to perform this action."
      redirect_to root_url
    end
  end

  def sort_column
    Review.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
