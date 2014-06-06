class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    render :layout => false
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to root_url
  	else
  		redirect_to new_session_url, :notice => "E-mail or password is invalid"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Successfully logged out"
  end
end
