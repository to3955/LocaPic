class Location < ApplicationRecord


  has_many :posts

  def self.looks(search, word)
    if search == "perfect_match"
      @locations = Location.where("place_name LIKE ? OR address LIKE ?", word, word)
    elsif search == "forward_match"
      @locations = Location.where("place_name LIKE ? OR address LIKE ?", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @locations = Location.where("place_name LIKE ? OR address LIKE ?", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      @locations = Location.where("place_name LIKE ? OR address LIKE ?", "%#{word}%", "%#{word}%")
    else
      @locations = Location.all
    end
  end

end
