class Post < ApplicationRecord
    # validates :image_url, presence: true
    belongs_to :user

    has_many :reposts, class_name: "Post", foreign_key: "repost_id", dependent: :destroy

    def self.posts_for_me(friends)
        where(user_id: friends.map {|friend| friend.friend_id})
    end

    def repost
        Post.find(self.repost_id)
    end

    def reposted?
        Post.find_by(repost_id: self.id) ? true : false
    end
end