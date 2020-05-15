class Users::LikesController < ApplicationController
	before_action :authenticate_user!
	def create
		like = Like.new(user_id: current_user.id, post_id: params[:post_id])
		@post = like.post
		like.save
	end

	def destroy
		like = Like.find(params[:id])
		@post = like.post
		like.destroy
	end
end
