class UsersController < ApplicationController
  before_action :load_user, only: [:show]

  def show
    @reviews = @user.reviews.page(params[:page]).per 10
    @total = @user.reviews.count
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless current_user == @user
      flash[:danger] = "You are not authorized to see this page."
      redirect_back fallback_location: root_path
    end
  end
end
