class Review < ApplicationRecord
  belongs_to :user
  belongs_to :food
  validates :rate, presence: true
  validates :comment, length: {maximum:Settings.maximum_length_comment}
end
