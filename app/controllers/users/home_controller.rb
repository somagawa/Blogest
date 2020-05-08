class Users::HomeController < ApplicationController
  def top
  	@posts = Post.all.limit(8)
  	@post_ranks = Post.all.limit(10)
  	@users = User.all.limit(10)
  end
end
