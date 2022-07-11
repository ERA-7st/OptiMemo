class CategoryWord < ApplicationRecord
  before_create :set_uuid

  belongs_to :category
  belongs_to :word

  validates :category_id, :word_id, presence: true
  validates :category_id, uniqueness: { scope: :word_id }

  private

  def set_uuid
    while self.id.blank? || CategoryWord.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end

end
