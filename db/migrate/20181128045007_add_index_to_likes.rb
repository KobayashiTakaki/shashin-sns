class AddIndexToLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :Likes, [:user_id, :post_id], unique: true
  end
end
