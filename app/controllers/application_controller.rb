class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :require_login

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def is_admin?
    true if current_user.role == 'admin'
    false
  end

  def require_login
  	unless current_user
  		redirect_to new_session_url
  	end
  end
end
