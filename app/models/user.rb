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
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  # validates :name, presence: true,
  #                 length: {maximum: 50,
  #                           message: "最大文字数は50文字です" },
  #                 format: { with: /\A[a-zA-Z0-9]+\z/,
  #                           message: "半角英数字のみが使用できます" },
  #                 uniqueness: { case_sensitive: true }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }
  # validates :display_name, presence: true,
  #                           length: {maximum: 50,
  #                                   message: "最大文字数は50文字です" }

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

  #コメントする
  def comment(post, content)
    Comment.create(user: self, post: post, content: content)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.display_name = ''
      user.picture = ''
      user.name = SecureRandom.hex

      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
  end
end

  private
    def downcase
      self.email = email.downcase
    end
end
