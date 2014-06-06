class DevicesController < ApplicationController
  respond_to :html
  load_and_authorize_resource

  # GET /devices
  # GET /devices.xml
  def index
    @devices = Device.all
    @devices = @devices.where(:type => params[:type]) if params.has_key?(:type)
    @devices = @devices.where(:server_id => params[:server_id]) if params.has_key?(:server_id)

    respond_with(@devices)
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show
    @device = Device.find(params[:id])

    @measurements_raw = Measurement
    @measurements_raw = @measurements_raw.where(:device_id => params[:id])
    @measurements_raw = @measurements_raw.where(:name => params[:name]) if params.has_key?(:name)
    @measurements_raw = @measurements_raw.where(:quantity => params[:quantity]) if params.has_key?(:quantity)
    @measurements_raw = @measurements_raw.pluck(:value)
    @measurements_raw = @measurements_raw.each_with_index.map { |i, index| i.to_f - @measurements_raw[index-1].to_f }
    @measurements_raw.shift


    #render :json => @device, :include => :measurements
  end

  # GET /devices/new
  # GET /devices/new.xml
  def new
    @device = Device.new
    @servers = Server.all
    respond_with(@device)
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.xml
  def create
    @device = Device.new(params[:device])
    @device.save

    flash[:notice] = 'Device was successfully created.' if @device.save
    respond_with(@device)
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    @device = Device.find(params[:id])
    flash[:notice] = 'Device was successfully updated.' if @device.update_attributes(params[:device])
    respond_with(@device)
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    respond_with(@device)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:server).permit(:name, :fqdn, :IPv4Address, :IPv6Address, :description)
    end
end
