class User::CategoriesController < ApplicationController

  before_action :user_logged_in?

  def index
    @categories = current_user.categories.all
  end

end