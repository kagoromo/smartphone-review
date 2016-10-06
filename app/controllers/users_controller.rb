class UsersController < ApplicationController
    def show
    @user = User.find(params[:id])
    @reviews = Review.where("user_id = ?", params[:id])
    @total = Review.where("user_id = ?", params[:id]).count 
    end
end
