class OrderItem < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :food
  after_save :sum

  def sum
    self.order.sum
  end
end
