class Admins::ReviewsController < ApplicationController
  before_action :require_admin
  before_action :load_review, except: [:index, :new, :create]

  def index
    @search = Review.ransack(params[:q])
    @reviews = @search.result.order(sort_column + " " + sort_direction).
      page(params[:page]).per 10
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
      respond_to do |format|
        format.html do
          flash[:success] = "The review has been successfully updated."
          redirect_to admins_reviews_path
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:danger] = "Failed to edit the review."
          render "edit"
        end
        format.js
      end
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
    params.require(:review).permit :title, :content, :device_id, :cover_image,
      :summary, :the_good, :the_bad, :score_design, :score_screen,
      :score_performance, :score_battery, :score_camera, :status, :tag_list
  end

  def sort_column
    Review.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
