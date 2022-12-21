class User::EachReviewsController < ApplicationController

  include Reviews

  before_action :user_logged_in?
  before_action :word_id_certification

  def check
  end

  def confirm
    render turbo_stream: turbo_stream.replace(
      "word_content",
      partial: "user/each_reviews/word_content",
      locals: { display: "true", word: @word }
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
    redirect_to reviews_path
  end

  def ambiguous
    score = @word.score
    days_left = set_days_left(score.phase)
    score.update(
      wrong_count: score.wrong_count + 1,
      days_left: days_left
    )
    redirect_to reviews_path
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
    redirect_to reviews_path
  end

  def word_id_certification
    @word = current_user.words.find(params[:id])
    unless @word
      redirect_back(fallback_location: user_home_top_path)
    end
  end

end
