class UsersController < ApplicationController
  def show
    @orders = current_user.orders.order(order_time: :desc)
  end
end
