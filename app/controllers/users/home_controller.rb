class Users::HomeController < ApplicationController
  def top
  	@posts = Post.includes(:post_images, :likes).limit(9).order(created_at: :desc)
  	@post_ranks = Post.ranking.limit(5)
  	@users = User.ranking.limit(5)
  end
end