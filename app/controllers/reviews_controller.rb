class ReviewsController < ApplicationController
  def new
    @order = current_user.orders.find(params[:order])
  end

  def create
    @order = current_user.orders.find(params[:order_id])
    @reviews = Array.new(@order.order_items.length) { current_user.reviews.new }
    @reviews.each_with_index do |review,i|
      review.food = @order.order_items[i].food
      review.rate = params[:rate]
      review.comment = params[:comment]
      review.save
    end
    @order.status = "reviewed"
    @order.save
    flash[:notice] = t 'flash.success'
    redirect_to user_path(current_user)
  end
end
