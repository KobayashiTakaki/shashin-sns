class User < ApplicationRecord
  require 'securerandom'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  mount_uploader :picture, PictureUploader
  before_save :downcase
  #has_secure_password
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article
  has_many :active_relationships, class_name: "Relationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                foreign_key: "followee_id",
                                dependent: :destroy
  has_many :following, through: :active_relationships, source: :followee
  has_many :followers, through: :passive_relationships, source: :follower
  validates :name, presence: true,
                  length: {maximum: 50,
                            message: "最大文字数は50文字です" },
                  format: { with: /\A[a-zA-Z0-9]+\z/,
                            message: "半角英数字のみが使用できます" },
                  uniqueness: { case_sensitive: true }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :display_name, length: {maximum: 50,
                                    message: "最大文字数は50文字です" }
  validates :password, length: {minimum: 6}, allow_blank: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #いいねする
  def like(article)
    Like.create(user: self, article: article)
  end

  #いいねを削除する
  def unlike(article)
    if like = Like.find_by(user: self, article: article)
      like.destroy
    end
  end

  #あるarticleをいいねしていたらtrueを返す
  def liked?(article)
    liked_articles.include?(article)
  end

  #コメントする
  def comment(article, content)
    Comment.create(user: self, article: article, content: content)
  end

  def feed

  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followee_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.display_name = ''
      user.picture = ''
      user.name = SecureRandom.alphanumeric(10)
    end
  end

  private
    def downcase
      self.email = email.downcase
    end
end
