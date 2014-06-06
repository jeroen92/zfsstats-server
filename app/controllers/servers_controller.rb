class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  # GET /servers
  # GET /servers.xml
  def index
    @servers = Server.all
    respond_with(@servers)
  end

  # GET /servers/1
  # GET /servers/1.xml
  def show
    @server = Server.find(params[:id])
    respond_with(@server)
  end

  # GET /servers/new
  # GET /servers/new.xml
  def new
    @server = Server.new
    respond_with(@server)
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.xml
  def create
    @server = Server.new(params[:server])
    flash[:notice] = 'Server was successfully created.' if @server.save
    respond_with(@server)
  end

  # PUT /servers/1
  # PUT /servers/1.xml
  def update
    @server = Server.find(params[:id])
    flash[:notice] = 'Server was successfully updated.' if @server.update_attributes(params[:server])
    respond_with(@server)
  end

  # DELETE /servers/1
  # DELETE /servers/1.xml
  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    respond_with(@server)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:server).permit(:name, :fqdn, :IPv4Address, :IPv6Address, :description, :user)
    end
end
