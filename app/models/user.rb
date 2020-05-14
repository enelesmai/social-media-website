class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  def friends
    friends_array = friendships.map { |f| f.friend if f.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirm my friend requests
  def pending_friends
    friendships.map { |f| f.friend unless f.confirmed }.compact
  end

  # Users who have requested to me to be friends
  def friends_requests
    Friendship.where(friend_id: id).map { |f| f.user unless f.confirmed }.compact
  end

  def request_friendship(user)
    friendships.build(friend_id: user.id, confirmed: nil)
    save
  end

  def confirm_friendship(user)
    friendship = Friendship.where(friend_id: id, confirmed: nil, user_id: user.id).first
    return if friendship.nil?

    # Creates the other direction friendship
    Friendship.create(user_id: id, friend_id: user.id, confirmed: true)
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def requested?(user)
    pending_friends.include?(user)
  end

  def pending?(user)
    friends_requests.include?(user)
  end

  def get_friendship(user)
    Friendship.where(friend_id: id, user_id:user.id, confirmed: nil).first
  end

  def friends_and_own_posts
    Post.where(user: friends << self).order(created_at: :desc)
  end
end
