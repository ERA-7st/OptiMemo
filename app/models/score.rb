class Score < ApplicationRecord
  before_create :set_uuid

  belongs_to :word

  validates :word_id, :correct_count, :wrong_count, :phase, :days_left, presence: true
  validates :correct_count, :wrong_count, :phase, :days_left, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :word_id, uniqueness: true

  def set_uuid
    while self.id.blank? || Score.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
