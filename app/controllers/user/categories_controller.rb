class User::CategoriesController < ApplicationController

  before_action :user_logged_in?

  def index
    @categories = current_user.categories.all.by_recently_created
    @new_category = Category.new
  end

  def create
    category = current_user.categories.new(category_params)
    if category.save
      redirect_back(fallback_location: user_home_top_path)
    else
      render turbo_stream: turbo_stream.replace(
        "errors",
        partial: 'layouts/error_message',
        locals: { model: category },
      )
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_back(fallback_location: user_home_top_path)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end