class Comment < ApplicationRecord
  belongs_to :user
  validates :content, presence: true,
                      length: {maximum: 200,
                                message: "最大文字数は200文字です"}
end
