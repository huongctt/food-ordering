class OrderAddressesController < ApplicationController
  before_action :find_order, only: :create
  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = current_user.order_addresses.build(address_params)
    respond_to do |format|
      if @order_address.save
        if params[:order_address][:is_using]
          current_user.add_using_address(@order_address)
        end
        format.html { redirect_to edit_order_path(@order), notice: "ok"}
        format.js
        format.json
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def address_params
    params.require(:order_address).permit :address
  end

  def find_order
    @order = current_user.orders.find_by  status: :init
    return if @order.present?

    @order = current_user.orders.build()
  end
end
