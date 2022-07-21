class User::CategoryWordsController < ApplicationController

  def modal_index
    if params[:seted_categories]
      @categories = current_user.categories.where.not(id: params[:seted_categories].keys)
      @seted_categories = params[:seted_categories].permit!
    else
      @categories = current_user.categories.all
    end
  end

  def set_category
    category = Category.find(params[:id])
    @seted_categories = { category.id => category.name }
    if params[:seted_categories]
      @seted_categories = @seted_categories.merge(params[:seted_categories].permit!)
    end
    render turbo_stream: turbo_stream.replace(
      "seted_categories",
      partial: "seted_categories",
      locals: { seted_categories: @seted_categories },
    )
  end

  def remove_category
    @seted_categories = params[:seted_categories].permit!
    @seted_categories.delete(params[:id])
    render turbo_stream: turbo_stream.replace(
      "seted_categories",
      partial: "seted_categories",
      locals: { seted_categories: @seted_categories },
    )
  end

end
