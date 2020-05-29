class Users::RelationshipsController < ApplicationController
	before_action :authenticate_user!
	def create
		relationship = Relationship.new(following_id: current_user.id, follower_id: params[:user_id])
		@user = relationship.follower
		relationship.save
	end

	def destroy
		relationship = Relationship.find(params[:id])
		@user = relationship.follower
		relationship.destroy
	end
end
