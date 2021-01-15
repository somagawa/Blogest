class Users::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit]

  def index
    @posts = Post.includes(:post_images, :likes).page(params[:page]).order(created_at: :desc)
    @category_form = ""
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
    @post = Post.includes(comments: :user).find(params[:id])
    @comment = Comment.new
    @relation = Post.where(category: @post.category).where.not(id: @post).includes(:post_images, :likes).limit(9)
    address = @post.address
    @map = Geocoder.coordinates(address)
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
    if params[:sort] == "新着順"
      @posts = Post.includes(:post_images, :tags, :likes).search(params[:keyword], params[:address], params[:category]).page(params[:page]).order(created_at: :desc)
    else
      result = Post.includes(:post_images, :tags).search(params[:keyword], params[:address], params[:category])
      @posts = result.ranking.page(params[:page])
    end
    @keyword_form = params[:keyword]
    @address_form = params[:address]
    @category_form = params[:category]
    @sort = params[:sort]
    render "index"
  end

  private

  def post_params
  	params.require(:post).permit(:title, :body, :post_code, :address, :category_id, post_images_images: [])
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    if current_user != post.user
      redirect_to posts_path
    end
  end
end

