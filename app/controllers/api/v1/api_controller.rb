module Api
  module V1
    class ApiController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      before_filter :require_login

      private
      def require_login
        puts session
        if !session[:user_id]
          authenticate_or_request_with_http_token do |token, options|
            Server.where(apiKey: token, IPv4Address: request.remote_ip).any?
          end
        end
      end
    end
  end
end
