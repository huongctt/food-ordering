class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum status: { declined: -1, init: 0, created: 1, accepted: 2, confirmed: 3, reviewed: 4}

  def sum
    self.totalprice = OrderItem.joins(:food).where(order_items: {order_id: self.id}).sum('order_items.quantity * foods.price')
    self.save
  end
end
