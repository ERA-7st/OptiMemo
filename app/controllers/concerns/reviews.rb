module Reviews
  extend ActiveSupport::Concern
  
    def update_phase(current_phase, status)
      if status == "remember"
        current_phase == 8 ? 8 : current_phase + 1
      elsif status == "forget"
        current_phase == 0 ? 0 : current_phase - 1
      end
    end

    def set_days_left(phase)
      days_lefts = [1,3,7,14,30,60,90,180,365]
      days_lefts[phase]
    end
  
  end