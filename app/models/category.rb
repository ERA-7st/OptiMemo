class Category < ApplicationRecord
  before_create :set_uuid
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }

  private
  def set_uuid
    while self.id.blank? || Category.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
