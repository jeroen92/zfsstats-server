module Api
  module V1
    class ServersController < ApiController
      before_action :set_server, only: [:show, :edit, :update, :destroy]
      respond_to :json

      # GET /servers
      # GET /servers.xml
      def index
        @servers = Server.all
        @servers = @servers.limit(params[:limit]) if params.has_key?(:limit)
        if params.has_key?(:order_by) && params.has_key?(:order)
          if Server.fields.keys.include?(params[:order_by]) || ['status'].include?(params[:order_by])
            @servers = @servers.sort_by!{ |s| s.send(params[:order_by])}
            @servers = @servers.reverse if params[:order] == 'desc'
          end
        end
        respond_with(@servers)
      end

      # GET /servers/1
      # GET /servers/1.xml
      def show
        @server = Server.find(params[:id])
        respond_with(@server)
      end

      # GET /servers/newd
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
        respond_with(@server)
      end

      # PUT /servers/1
      # PUT /servers/1.xml
      def update
        @server = Server.find(params[:id])
        @server.update_attributes(params[:server])
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
        def server_params
          params.require(:server).permit(:name, :fqdn, :IPv4Address, :IPv6Address, :description)
        end
    end
  end
end