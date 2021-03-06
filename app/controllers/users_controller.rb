class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_with @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_with @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.update(user_params)
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_with @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if current_user.admin
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :measurementInterval, :role)
      else
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :measurementInterval)
      end
    end
end
