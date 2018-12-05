class ChangePostsToArticles < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :articles
  end
end
