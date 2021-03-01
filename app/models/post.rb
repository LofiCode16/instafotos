class Post < ApplicationRecord
    attr_accessor :repost

    validates :image_url, presence: true, unless: :repost
    belongs_to :user

    has_many :reposts, class_name: "Post", foreign_key: "repost_id", dependent: :destroy

    scope :posts_for_me, ->(friends) { where(user_id: friends.map {|friend| friend.friend_id}).order(created_at: :desc).includes(:user) }
    scope :explore, -> { all.order(created_at: :desc).includes(:user) }
    scope :friend_posts, ->(id) { where(user_id: id).order(created_at: :desc) }
    scope :search_post, ->(q) { where('content LIKE ?', "%#{q}%").order(created_at: :desc).includes(:user) }


    def repost
        Post.find(self.repost_id) unless self.repost_id.nil?
    end

    def reposted?
        Post.find_by(repost_id: self.id) ? true : false
    end
end