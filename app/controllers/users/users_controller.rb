class Users::UsersController < ApplicationController
  def index
  	@users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    if params[:tab] == "いいね"
      @posts = @user.like_posts
      @tab = "いいね"
    else
      @posts = @user.posts
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user)
  	else
  		render "edit"
  	end
  end

  def destroy_page
    
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :email)
  end
end
