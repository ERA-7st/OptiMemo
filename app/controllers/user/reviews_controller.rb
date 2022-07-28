class User::ReviewsController < ApplicationController

  before_action :user_logged_in?
  before_action :set_words, only: [:index, :check]
  before_action :word_id_certification, only: [:confirm]
  
  def indexd
    @display = "false"
  end

  def check
    @word = @words.first
  end

  def confirm
    render turbo_stream: turbo_stream.replace(
      "word_content",
      partial: 'user/reviews/word_content',
      locals: { display: "true", word: @word}
    )
  end

  def set_words
    @words =  current_user.words
      .eager_load(:score)
      .where(score: {days_left: 0})
      .order("score.updated_at ASC")
  end

  def word_id_certification
    @word = current_user.words.find(params[:id])
    unless @word || @word.days_left == 0
      redirect_back(fallback_location: user_home_top_path)
    end
  end

end
