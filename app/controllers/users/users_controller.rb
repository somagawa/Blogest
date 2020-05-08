class Users::UsersController < ApplicationController
  def index
  	@users = User.page(params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts
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
