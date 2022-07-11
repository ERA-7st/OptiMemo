class Word < ApplicationRecord
  before_create :set_uuid

  belongs_to :user
  has_many :category_words, dependent: :destroy
  has_many :categories, through: :category_words

  validates :word, :user_id, :content, presence: true
  validates :word, length: { maximum: 20 }
  validates :word, uniqueness: { scope: :user_id }

  private
  def set_uuid
    while self.id.blank? || Word.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
