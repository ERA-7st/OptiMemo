module ApplicationHelper

  def unchecked_words
    words_count = current_user.words
                              .eager_load(:score)
                              .where(score: {days_left: 0})
                              .count
    if words_count > 99
      "99+"
    else
      "#{words_count}"
    end
  end

end
