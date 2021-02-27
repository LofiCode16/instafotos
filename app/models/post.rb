class Post < ApplicationRecord
    validates :image_url, presence: true

    belongs_to :users
end