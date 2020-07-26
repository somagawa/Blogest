class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admins_users_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
