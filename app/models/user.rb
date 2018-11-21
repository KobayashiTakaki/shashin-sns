class User < ApplicationRecord
  has_many :posts
  validates :name, presence: true,
                  length: {maximum: 20,
                            message: "最大文字数は20文字です"},
                  format: { with: /\A[a-zA-Z0-9]+\z/,
                            message: "半角英数字のみが使用できます" }
  has_secure_password
end
