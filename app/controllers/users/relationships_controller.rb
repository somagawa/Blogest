class Users::RelationshipsController < ApplicationController
	def create
		relationship = Relationship.new(following_id: current_user.id, follower_id: params[:user_id])
		relationship.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		relationship = Relationship.find(params[:id])
		relationship.destroy
		redirect_back(fallback_location: root_path)
	end
end
