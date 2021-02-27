class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_save :friend_self

  has_many :posts, dependent: :destroy
  has_many :friends, dependent: :destroy

  def to_s
    self.name
  end

  def friend_self
    Friend.create!(
      user_id: self.id,
      friend_id: self.id
    )
  end

end
