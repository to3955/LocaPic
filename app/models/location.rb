class Location < ApplicationRecord


  has_many :posts
  validates :latitude, presence: true
  validates :longitude, presence: true

  # 検索メソッドの追加
  def self.search_by_place_name_or_address(keyword)
    if keyword.present?
      where("place_name LIKE :keyword OR address LIKE :keyword", keyword: "%#{keyword}%")
    else
      all
    end
  end


end
