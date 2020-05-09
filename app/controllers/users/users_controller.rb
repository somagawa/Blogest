class Users::UsersController < ApplicationController
  def index
  	@users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    if params[:tab] == "いいね"
      @posts = @user.like_posts.page(params[:page])
      @tab = "いいね"
    elsif params[:tab] == "フォロー"
      @users = @user.followings.page(params[:page])
      @tab = "フォロー"
    elsif params[:tab] == "フォロワー"
      @users = @user.followers.page(params[:page])
      @tab = "フォロワー"
    else
      @posts = @user.posts.page(params[:page])
      @tab = "記事一覧"
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
