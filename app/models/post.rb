class Post < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
  belongs_to :user
  validates :user_id, presence: true
  validate  :picture_size
  has_many :likes, dependent: :destroy

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "ファイルサイズは3MBまでです")
      end
    end
end
