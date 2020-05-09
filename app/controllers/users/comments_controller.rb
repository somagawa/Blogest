class Users::CommentsController < ApplicationController
	def create
		comment = Comment.new(comment_params)
		comment.user_id = current_user.id
		comment.post_id = params[:post_id]
		comment.save
		@post = comment.post
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
