class SearchHistory < ApplicationRecord
   belongs_to :user

 def to_term
  self.term
 end


end
