class User < ApplicationRecord
  before_save :downcase
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: true,
                  length: {maximum: 20,
                            message: "最大文字数は20文字です" },
                  format: { with: /\A[a-zA-Z0-9]+\z/,
                            message: "半角英数字のみが使用できます" },
                  uniqueness: { case_sensitive: true }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :display_name, presence: true,
                            length: {maximum: 50,
                                    message: "最大文字数は50文字です" }
  private
    def downcase
      self.email = email.downcase
    end
end
