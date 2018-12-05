class Article < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
  belongs_to :user
  validates :user_id, presence: true
  validate  :picture_size
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "ファイルサイズは3MBまでです")
      end
    end
end
