class Post < ApplicationRecord
    attr_accessor :repost

    validates :image_url, presence: true, unless: :repost
    belongs_to :user

    has_many :reposts, class_name: "Post", foreign_key: "repost_id", dependent: :destroy

    def self.posts_for_me(friends)
        where(user_id: friends.map {|friend| friend.friend_id}).order(created_at: :desc)
    end

    def repost
        Post.find(self.repost_id) unless self.repost_id.nil?
    end

    def reposted?
        Post.find_by(repost_id: self.id) ? true : false
    end
end