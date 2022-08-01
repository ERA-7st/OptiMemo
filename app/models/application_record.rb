class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :by_recently_updated, -> { order(updated_at: :desc) }
  scope :by_earliest_updated, -> { order(updated_at: :asc) }

end
