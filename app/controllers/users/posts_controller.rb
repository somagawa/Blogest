class Users::PostsController < ApplicationController
  def index
      @posts = Post.page(params[:page]).order(created_at: :desc)
      @tags = ActsAsTaggableOn::Tag.most_used(50)
      @tag_form = ""
      @sort = "新着順"
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
    if params[:search_tag] != "" && params[:sort] == "新着順"
      @posts = Post.search(params[:keyword]).tagged_with(params[:search_tag]).page(params[:page]).order(created_at: :desc)

    elsif params[:search_tag] != "" && params[:sort] == "いいね順"
      post_like_count = Post.joins(:likes).group(:post_id).count
      post_liked_ids = Hash[post_like_count.sort_by{ |_, v| -v }].keys
      post_ranking = Post.where(id: post_liked_ids)
      @posts = post_ranking.search(params[:keyword]).tagged_with(params[:search_tag]).page(params[:page])

    elsif params[:search_tag] == "" && params[:sort] == "新着順"
      @posts = Post.search(params[:keyword]).page(params[:page]).order(created_at: :desc)

    else
      post_like_count = Post.joins(:likes).group(:post_id).count
      post_liked_ids = Hash[post_like_count.sort_by{ |_, v| -v }].keys
      post_ranking = Post.where(id: post_liked_ids)
      @posts = post_ranking.search(params[:keyword]).page(params[:page])

    end
    @tags = ActsAsTaggableOn::Tag.most_used(50)
    @keyword_form = params[:keyword]
    @tag_form = params[:search_tag]
    @sort = params[:sort]
    render 'index'
  end

  private

  def post_params
  	params.require(:post).permit(:title, :body, :image, :post_code, :address, :tag_list)
  end
end
