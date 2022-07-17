class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :by_recently_updated, -> { order(updated_at: :desc) }

end
