class Post < ApplicationRecord

  belongs_to :user
  has_one :location
  has_one_attached :image
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy

  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def likes_count
    likes.count
  end

end
