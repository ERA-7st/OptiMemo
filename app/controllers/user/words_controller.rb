class User::WordsController < ApplicationController

  before_action :user_logged_in?

  def index
    @words = current_user.words.all
  end

end
