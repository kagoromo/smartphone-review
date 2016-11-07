class DevicesController < ApplicationController
  before_action :set_device, only: [:show]

  def index
    @search = Device.ransack(params[:q])
    @devices = @search.result.order(sort_column + " " + sort_direction).
      page(params[:page]).per 10
    @hot_reviews = Review.approved.with_in_30_days.
      order("counter_cache DESC").limit 5
  end

  def show
    @hot_reviews = Review.approved.with_in_30_days.
      order("counter_cache DESC").limit 5
  end

  private
  def set_device
    @device = Device.find params[:id]
  end

  def sort_column
    Review.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
