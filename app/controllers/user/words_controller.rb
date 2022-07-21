class User::WordsController < ApplicationController

  before_action :user_logged_in?

  def index
    @words = current_user.words.all.by_recently_updated
  end

  def new
    @new_word = Word.new
  end

  def show
    @word = Word.find(params[:id])
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @word = current_user.words.new(word_params)
        @word.save!
        @score = Score.new(word_id: @word.id)
        @score.save!
        if params[:seted_categories]
          params[:seted_categories].each do |id|
            @category_word = @word.category_words.new(category_id: id)
            @category_word.save!
          end
        end
        redirect_to words_path
      end
    rescue => e
      error_model = @category_word || @score || @word
      render turbo_stream: turbo_stream.replace(
        "errors",
        partial: 'layouts/error_message',
        locals: { model: error_model },
      )
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    redirect_back(fallback_location: user_home_top_path)
  end

  private

  def word_params
    params.require(:word).permit(:word, :content)
  end

end