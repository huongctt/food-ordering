class Food < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews
  accepts_nested_attributes_for :images
  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: {minimum:Settings.minimum_length_description, maximum:Settings.maximum_length_description}
  scope :by_price, ->(first_price, last_price) do
    where("price BETWEEN ? AND ?", first_price, last_price)
  end
end
