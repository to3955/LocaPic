class Reply < ApplicationRecord

  belongs_to :user
  belongs_to :post

 validates :content, presence: true
end
