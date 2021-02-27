class Post < ApplicationRecord
    validates :image_url, presence: true
    belongs_to :user

    def self.posts_for_me(friends)
        where(user_id: friends.map {|friend| friend.friend_id})
    end
end