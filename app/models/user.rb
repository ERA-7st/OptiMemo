class User < ApplicationRecord
  before_create :set_uuid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :name, presence: true, length: { maximum: 10 } 

  has_one  :periodic_mail, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :words, dependent: :destroy

  private
  def set_uuid
    while self.id.blank? || User.find_by(id: self.id).present? do
      self.id = SecureRandom.uuid
    end
  end

end
