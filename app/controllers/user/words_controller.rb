class User::WordsController < ApplicationController

  before_action :user_logged_in?

  def index
    @words = current_user.words.all
  end

  def new
    @new_word = Word.new
  end

  def create
    word = current_user.words.new(word_params)
    if word.save
      redirect_to words_path
    else
      render turbo_stream: turbo_stream.replace(
        "errors",
        partial: 'layouts/error_message',
        locals: { model: word },
      )
    end
  end

  private

  def word_params
    params.require(:word).permit(:word, :content)
  end

end
