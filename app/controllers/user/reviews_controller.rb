class User::ReviewsController < ApplicationController

  before_action :user_logged_in?
  
  def index
    @words =  current_user.words
      .eager_load(:score)
      .where(score: {days_left: 0})
  end

end
