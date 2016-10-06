class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "The user has been successfully created."
    else
      flash.now[:danger] = "Failed to create the user."
    end
    redirect_to admin_users_path
  end

  def update
     @user = User.find_by id: params[:id]
     if @user.update_attributes(user_params)
      flash[:success] = "The user has been successfully update."
     else
      flash.now[:danger] = "Failed to update the user."
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = "The user has been successfully delete."
    else
      flash.now[:danger] = "Failed to update the user."
    end
    redirect_to admin_users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit :email, :password
    end
end
