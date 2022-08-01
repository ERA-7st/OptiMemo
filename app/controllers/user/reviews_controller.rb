class User::ReviewsController < ApplicationController

  include Reviews

  before_action :user_logged_in?
  before_action :set_words, only: [:index, :check]
  before_action :word_id_certification, only: [:confirm, :remember, :ambiguous, :forget]
  
  def indexd
    @display = "false"
  end

  def check
    unless @words.count == 0
      @word = @words.first
    end
  end

  def confirm
    render turbo_stream: turbo_stream.replace(
      "word_content",
      partial: 'user/reviews/word_content',
      locals: { display: "true", word: @word}
    )
  end

  def remember
    score = @word.score
    phase = update_phase(score.phase, "remember")
    days_left = set_days_left(phase)
    score.update(
      correct_count: score.correct_count + 1,
      days_left: days_left,
      phase: phase
    )
    redirect_to check_path
  end

  def ambiguous
    score = @word.score
    days_left = set_days_left(score.phase)
    score.update(
      wrong_count: score.wrong_count + 1,
      days_left: days_left,
    ) 
    redirect_to check_path
  end

  def forget
    score = @word.score
    phase = update_phase(score.phase, "forget")
    days_left = set_days_left(phase)
    score.update(
      wrong_count: score.wrong_count + 1,
      days_left: days_left,
      phase: phase
    ) 
    redirect_to check_path
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
