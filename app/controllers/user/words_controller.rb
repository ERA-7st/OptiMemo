class User::WordsController < ApplicationController

  before_action :user_logged_in?
  before_action :correct_seted_categories, only: [:create, :update]

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
        if params[:new_categories]
          params[:new_categories].each do |name|
            @new_category = current_user.categories.new(name: name)
            @new_category.save!
            @category_word = @word.category_words.new(category_id: @new_category.id)
            @category_word.save!
          end
        end
        if params[:seted_categories]
          params[:seted_categories].each do |id|
            @category_word = @word.category_words.new(category_id: id)
            @category_word.save!
          end
        end
        redirect_to words_path
      end
    rescue => e
      error_model = @new_category || @category_word || @score || @word
      render turbo_stream: turbo_stream.replace(
        "errors",
        partial: 'layouts/error_message',
        locals: { model: error_model },
      )
    end
  end

  def edit
    @word = current_user.words.find(params[:id])
    seted_categories = @word.categories
    @seted_categories = {}
    seted_categories.each do |category|
      @seted_categories.merge!({ category.id => category.name })
    end
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        @word = current_user.words.find(params[:id])
        @word.update!(word_params)
        if params[:reset_score]
          @score = @word.score
          @score.update!(
            correct_count: 0,
            wrong_count: 0,
            phase: 0,
            days_left: 1
          )
        end
        before_update_categories = []
        @word.categories.each do |category|
          before_update_categories.push(category.id) 
        end
        (before_update_categories - params[:seted_categories]).each do | id |
          @category_word = @word.category_words.find_by(category_id: id)
          @category_word.destroy!
        end
        (params[:seted_categories] - before_update_categories).each do | id |
          @category = @word.category_words.new(category_id: id)
          @category.save!
        end
        if params[:new_categories]
          params[:new_categories].each do |name|
            @new_category = current_user.categories.new(name: name)
            @new_category.save!
            @category_word = @word.category_words.new(category_id: @new_category.id)
            @category_word.save!
          end
        end
        redirect_to words_path
      end
    rescue => e
      error_model = @new_category || @category_word || @score || @word
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

  def correct_seted_categories
    params[:seted_categories].each do |id|
      unless current_user.categories.find_by_id(id)
        redirect_back(fallback_location: user_home_top_path)
      end
    end
  end
end