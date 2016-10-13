class DevicesController < ApplicationController
  before_action :set_device, only: [:show]

  def index
    @devices = Device.all.page(params[:page]).per 10
  end

  def show
  end

  private
  def set_device
    @device = Device.find params[:id]
  end
end
