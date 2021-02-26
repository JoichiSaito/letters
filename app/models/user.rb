class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :position, presence: true

  has_many :boards, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :joined_boards, through: :joins, source: :board

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower, dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following, dependent: :destroy

  has_many :active_requests, class_name: 'Request', foreign_key: :refollowing_id, dependent: :destroy
  has_many :refollowings, through: :active_requests, source: :refollower, dependent: :destroy

  has_many :passive_requests, class_name: 'Request', foreign_key: :refollower_id, dependent: :destroy
  has_many :refollowers, through: :passive_requests, source: :refollowing, dependent: :destroy

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def requested_by?(user)
    passive_requests.find_by(refollowing_id: user.id).present?
  end
end
