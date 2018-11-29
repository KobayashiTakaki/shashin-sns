class User < ApplicationRecord
  before_save :downcase
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
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

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #いいねする
  def like(post)
    Like.create(user: self, post: post)
  end

  #いいねを削除する
  def unlike(post)
    if like = Like.find_by(user: self, post: post)
      like.destroy
    end
  end

  #あるpostをいいねしていたらtrueを返す
  def liked?(post)
    liked_posts.include?(post)
  end

  private
    def downcase
      self.email = email.downcase
    end
end
