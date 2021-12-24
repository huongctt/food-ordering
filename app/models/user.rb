class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :order_addresses
  has_many :order_items
  has_many :orders
  has_many :reviews

  def add_using_address(order_address)
    self.order_addresses.update_all is_using: false
    order_address.is_using = true
    order_address.save
  end
end
