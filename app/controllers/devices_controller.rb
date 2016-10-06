class DevicesController < ApplicationController
  before_action :require_admin
  before_action :set_device, except: [:index, :new, :create]

  def index
    @devices = Device.all
  end

  def show
  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      flash[:success] = "New divide has been successfully created."
    else
      flash.now[:danger] = "Failed to create new divide."
    end

    redirect_to devices_path
  end

  def update

    if @device.update(device_params)
      flash[:success] = "Device has been successfully updated."
    else
      flash.now[:danger] = "Failed to update device."
    end

    redirect_to devices_path
  end

  def destroy
    @device = Device.find_by id: params[:id]
    if @device.destroy

    else

    end

    redirect_to devices_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :content)
  end
end
