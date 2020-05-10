class Users::PostsController < ApplicationController
  def index
      @posts = Post.page(params[:page])
      @tags = ActsAsTaggableOn::Tag.most_used(50)
      @tag_form = ""
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		redirect_to post_path(@post)
  	else
  		render "new"
  	end
  end

  def show
  	@post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update(post_params)
  		redirect_to post_path(@post)
  	else
  		render "edit"
  	end
  end

  def destroy
  	post = Post.find(params[:id])
  	post.destroy
  	redirect_to posts_path
  end

  def search
    @posts = Post.tagged_with(params[:search_tag]).page(params[:page]).order(created_at: :desc)
    @tag_form = params[:search_tag]
    @tags = ActsAsTaggableOn::Tag.most_used
    render 'index'
  end

  private

  def post_params
  	params.require(:post).permit(:title, :body, :image, :tag_list)
  end
end
