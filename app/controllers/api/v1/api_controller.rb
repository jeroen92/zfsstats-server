include ActionController::HttpAuthentication::Token


module Api
  module V1
    class ApiController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      before_filter :require_login
      load_and_authorize_resource

      rescue_from ::CanCan::AccessDenied do
        render :text => "You do not have access to this resource", :status => :forbidden
      end


      private
      def require_login
        puts session
        if !session[:user_id]
          authenticate_or_request_with_http_token do |token, options|
            if Server.where(apiKey: token, IPv4Address: request.remote_ip).any?
              @current_user = User.new(:_id => Server.where(apiKey: token, IPv4Address: request.remote_ip).first._id, :role => 'server')
            end
          end
        end
      end

      def current_user
        if !session[:user_id] && token_and_options(request)
          api_key = token_and_options(request)[0]
          @current_user ||= User.new(:_id => Server.where(apiKey: api_key, IPv4Address: request.remote_ip).first._id, :role => 'server') if api_key
        else
          @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end
      end
    end
  end
end