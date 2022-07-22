class User::CategoryWordsController < ApplicationController

  def modal_index
    if params[:seted_categories]
      @categories = current_user.categories.where.not(id: params[:seted_categories].keys)
      @seted_categories = params[:seted_categories].permit!
    else
      @categories = current_user.categories.all
    end
    @new_categories = params[:new_categories] || []
  end

  def set_category
    category = Category.find(params[:id])
    @seted_categories = { category.id => category.name }
    if params[:seted_categories]
      @seted_categories = @seted_categories.merge(params[:seted_categories].permit!)
    end
    @new_categories = params[:new_categories] if params[:new_categories]
    render turbo_stream: turbo_stream.replace(
      "seted_categories",
      partial: "seted_categories",
      locals: { seted_categories: @seted_categories, new_categories: @new_categories },
    )
  end

  def remove_category
    @seted_categories = params[:seted_categories].permit!
    @seted_categories.delete(params[:id])
    @new_categories = params[:new_categories] if params[:new_categories]
    render turbo_stream: turbo_stream.replace(
      "seted_categories",
      partial: "seted_categories",
      locals: { seted_categories: @seted_categories, new_categories: @new_categories },
    )
  end

  def set_new_category
    @seted_categories = params[:seted_categories].permit! if params[:seted_categories]
    @new_category = current_user.categories.new(name: params[:name])
    if @new_category.valid?
      @new_categories = [ @new_category.name ]
      if params[:new_categories] && params[:new_categories].find{ |n| n == params[:name] }
        render turbo_stream: turbo_stream.replace(
          "modal_errors",
          partial: 'layouts/modal_error_message',
          locals: { model: nil ,error_message: "already exists" },
        ),status: :unprocessable_entity
      else
        @new_categories = @new_categories.concat(params[:new_categories]) if params[:new_categories]
        render turbo_stream: turbo_stream.replace(
          "seted_categories",
          partial: "seted_categories",
          locals: { seted_categories: @seted_categories, new_categories: @new_categories },
        )
      end
    else
      render turbo_stream: turbo_stream.replace(
        "modal_errors",
        partial: 'layouts/modal_error_message',
        locals: { model: @new_category, error_message: nil },
      ),status: :unprocessable_entity
    end
  end

  def remove_new_category
    @new_categories = params[:new_categories]
    @new_categories.delete(params[:name])
    @seted_categories = params[:seted_categories].permit! if params[:seted_categories]
    render turbo_stream: turbo_stream.replace(
      "seted_categories",
      partial: "seted_categories",
      locals: { seted_categories: @seted_categories, new_categories: @new_categories },
    )
  end

end
