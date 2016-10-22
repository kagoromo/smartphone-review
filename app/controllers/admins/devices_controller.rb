class Admins::DevicesController < ApplicationController
  before_action :require_admin
  before_action :set_device, except: [:index, :new, :create]

  def index
    @search = Device.ransack(params[:q])
    @devices = @search.result.order(sort_column + " " + sort_direction).
      page(params[:page]).per 10
  end

  def show
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      flash[:success] = "The new device has been successfully created."
      redirect_to admins_devices_path
    else
      flash.now[:danger] = "Failed to create the new device."
      render :new
    end
  end

  def edit
  end

  def update

    if @device.update(device_params)
      flash[:success] = "The device has been successfully updated."
      redirect_to admins_devices_path
    else
      flash.now[:danger] = "Failed to update the device."
      render :edit
    end
  end

  def destroy
    @device = Device.find_by id: params[:id]
    if @device.destroy
      flash[:success] = "The device has been successfully deleted."
    else
      flash[:danger] = "Failed to delete the device."
    end
    redirect_to admins_devices_path
  end

  private
  def set_device
    @device = Device.find params[:id]
  end

  def device_params
    params.require(:device).permit :name, :content
  end
  
  def sort_column
    Review.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
