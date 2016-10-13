class Admins::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all.page(params[:page]).per 10
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "The user has been successfully created."
      redirect_to admins_users_path
    else
      flash.now[:danger] = "Failed to create the user."
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = "The user has been successfully update."
      redirect_to admins_users_path
    else
      flash.now[:danger] = "Failed to update the user."
      render :edit
    end
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = "The user has been successfully delete."
    else
      flash[:danger] = "Failed to update the user."
    end
    redirect_to admins_users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit :email, :password
    end
end
