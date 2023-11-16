class Reply < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length: { minimum: 1 }

end
