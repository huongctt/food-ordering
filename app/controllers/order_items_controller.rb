class OrderItemsController < ApplicationController
  before_action :find_order, only: [:create, :destroy]
  before_action :find_order_item, only: :destroy

  def new
    @order_item = OrderItem.new
  end

  def create
    add_order_item params[:order_item][:food_id].to_i
    if @order_item.save
      flash[:notice] = t 'flash.item.success'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    if @order_item.destroy
      @order.sum
      flash[:success] = t 'flash.orderitem.delete'
    else
      flash[:notice] = t 'flash.orderitem.notdelete'
    end
    redirect_to cart_path
  end

  private

  def item_params
    params.require(:order_item).permit :quantity, :food_id
  end

  def find_order
    @order = current_user.orders.find_by status: 0
    return if @order.present?

    @order = current_user.orders.build()
    @order.save
  end

  def add_order_item food_id
    @order.order_items.each do |item|
      if item.food_id == food_id
        @order_item = item
        @order_item.quantity += params[:order_item][:quantity].to_i
        return
      end
    end
    @order_item = current_user.order_items.build(item_params)
    @order_item.order_id = @order.id
  end

  def find_order_item
    @order_item = current_user.order_items.find_by(id: params[:id])
    return if @order_item.present?

    redirect_to root_url, notice: t('flash.orderitem.notfound')
  end
end
