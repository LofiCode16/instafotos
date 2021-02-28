class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_save :friend_self

  has_many :posts, dependent: :destroy
  has_many :friends, dependent: :destroy


  def friend_self
    Friend.create!(
      user_id: self.id,
      friend_id: self.id
    )
  end

  def is_friend_of(user)
    self.friends.pluck(:friend_id).include?(user.id) ? true : false
  end

  def all_friends
    @friend_ids = self.friends.pluck(:friend_id)

    @friends = []

    @friend_ids.each do |friend_id|
      @friends << User.find(friend_id)
    end

    return @friends
  end
end
