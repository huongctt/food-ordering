class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :show, :update]
  before_action :require_admin, only: [:index]

  def show
  end

  def index
    @orders = Order.all.order(order_time: :desc)
  end

  def edit
    @order_address = OrderAddress.new
    @order_addresses = current_user.order_addresses
  end

  def create_address
    @order_address = current_user.order_addresses.build(address_params)
    respond_to do |format|
      if @order_address.save
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @order_address.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if @order.update(order_params)
      flash[:notice] = t('flash.order.success')
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def accept
    @order = Order.find_by id: params[:id]
    if @order.update(params.permit(:status))
      flash[:notice] = t('flash.order.success')
      redirect_to orders_path
    else
      render 'edit'
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
    if @order.update(params.permit(:status))
      flash[:notice] = t('flash.order.success')
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end

  private

  def find_order
    @order = current_user.orders.find_by status: :init
  end

  def order_params
    params.require(:order).permit(:address, :status, :order_time)
  end

  def require_admin
    redirect_to root if !current_user.admin?
  end

  def address_params
    params.require(:order_address).permit(:address, :is_using)
  end
end
