class AddRepostToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :repost_id, :integer, index: true
    add_foreign_key :posts, :posts, column: :repost_id
  end
end
