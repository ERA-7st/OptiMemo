class Category < ApplicationRecord
  before_create :set_uuid
  belongs_to :user

  validates :name, :user_id, presence: true
  validates :name, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :user_id }

  private
  def set_uuid
    while self.id.blank? || Category.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
