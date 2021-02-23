class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :joined_users, through: :joins, source: :user

  def joined_by?(user)
    joins.find_by(user_id: user.id).present?
  end
end
