class ChangeCommentsReferencesColumns < ActiveRecord::Migration[5.2]
  def change
    change_table :comments do |t|
      t.rename :post_id, :article_id
    end
  end
end
