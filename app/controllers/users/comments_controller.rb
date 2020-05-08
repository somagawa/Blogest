class Users::CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.post_id = params[:post_id]
		if @comment.save
			redirect_to post_path(@comment.post_id)
		else
			@post = @comment.post
			render "users/posts/show"
		end
	end

	def destroy
		comment = Comment.find(params[:id])
		comment.destroy
		redirect_to post_path(comment.post)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
