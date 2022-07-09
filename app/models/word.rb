class Word < ApplicationRecord
  before_create :set_uuid
  belongs_to :user

  validates :word, :user_id, :converted_word, :content, presence: true
  validates :word, length: { maximum: 20 }
  validates :word, uniqueness: { scope: :user_id }

  private
  def set_uuid
    while self.id.blank? || Word.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
