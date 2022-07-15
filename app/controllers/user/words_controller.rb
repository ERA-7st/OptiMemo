class User::WordsController < ApplicationController

  before_action :user_logged_in?

  def index
    @words = current_user.words.all.by_recently_updated
  end

  def new
    @new_word = Word.new
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @word = current_user.words.new(word_params)
        @word.save!
        @score = Score.new(word_id: @word.id)
        @score.save!
        redirect_to words_path
      end
    rescue => e
      error_model = @score || @word
      render turbo_stream: turbo_stream.replace(
        "errors",
        partial: 'layouts/error_message',
        locals: { model: error_model },
      )
    end
  end

  private

  def word_params
    params.require(:word).permit(:word, :content)
  end

end