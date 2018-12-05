class ChangeLikesReferenceColmuns < ActiveRecord::Migration[5.2]
  def change
    change_table :likes do |t|
      t.remove_index :post_id
      t.remove_index [:user_id, :post_id]
      t.rename :post_id, :article_id
      t.index :article_id
      t.index [:user_id, :article_id]
    end
  end
end
