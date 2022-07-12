class PeriodicMail < ApplicationRecord
  before_create :set_uuid
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true

  private
  def set_uuid
    while self.id.blank? || PeriodicMail.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end
end
