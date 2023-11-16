class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :replies, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :search_histories

  validate :validate_profile_image

  GUEST_USER_EMAIL = "guest@example.com"

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end


  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed

  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower

  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def self.search_by_name(keyword)
    if keyword.present?
      where("last_name LIKE :keyword OR first_name LIKE :keyword OR (last_name || ' ' || first_name) LIKE :keyword", keyword: "%#{keyword}%")
    else
      all
    end
  end

  def guest?
  # 通常のユーザーかどうかを判別する条件を記述
  # 例: ゲストユーザーは email が 'guest@example.com' の場合と仮定
  self.email == 'guest@example.com'
  end

  def self.guest
  find_or_create_by(email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.last_name = "ゲスト"
    user.first_name = "ユーザー"
    user.last_name_kana = "ゲスト"
    user.first_name_kana = "ユーザー"
    # その他の属性を設定する場合はここで設定
    end
  end

  def send_message(subject, content, sender)
    # ここにメッセージ送信の処理を追加
    # 例: メッセージをデータベースに保存する
    Message.create(subject: subject, content: content, sender: sender, recipient: self)
  end

  private

  def validate_profile_image
    if profile_image.attached?
      allowed_types = %w[image/jpeg image/png]
      unless allowed_types.include?(profile_image.content_type)
        errors.add(:profile_image, 'must be a valid image file (JPEG or PNG)')
      end
    end
  end


end
