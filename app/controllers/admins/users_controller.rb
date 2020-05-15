class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	def index
		@users = User.page(params[:page]).per(10)
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
	end
end
