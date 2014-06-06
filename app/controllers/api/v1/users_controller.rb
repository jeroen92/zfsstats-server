module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :edit, :update, :destroy]
      respond_to :json

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

      # POST /users
      # POST /users.json
      def create
        @user = User.new(user_params)
        @user.save
        return @user
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
            params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :role)
          else
            params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
          end
        end
    end
  end
end