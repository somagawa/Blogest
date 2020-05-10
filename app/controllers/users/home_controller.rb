class Users::HomeController < ApplicationController
  def top
  	@posts = Post.all.limit(9).order(created_at: :desc)
  	@post_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  	@users = User.find(Relationship.group(:follower_id).order('count(follower_id) desc').limit(10).pluck(:follower_id))
  	@tags = ActsAsTaggableOn::Tag.most_used(50)
  end
end