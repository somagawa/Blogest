class Users::HomeController < ApplicationController
  def top
  	@posts = Post.all.limit(9).order(created_at: :desc)
  	@post_ranks = Post.all.limit(10)
  	@users = User.all.limit(10)
  	@tags = ActsAsTaggableOn::Tag.most_used(50)
  end
end
