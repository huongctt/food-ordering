require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:user){ FactoryBot.create :user}
  let!(:food){ FactoryBot.create :food}
  let!(:order){ FactoryBot.create :order , user: user, status: 0}
  let!(:order_item){ FactoryBot.create :order_item , user: user}

  before do
    sign_in user
  end

  describe "POST #create" do
    context "With valid attributes" do
      before{post :create, params: {order_item: {quantity: 3, food_id: food.id}}}

      it "creates a new category" do
        expect(assigns(:order_item)).to be_a OrderItem
      end

      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "redirects to the new category" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "DELETE /destroy" do
    context "when not found order_item to destroy" do
      before do
        delete :destroy, params: {id: -1}
      end

      it "will redirect to root page" do
        expect(response).to redirect_to root_path
      end

      it "will have flash danger present" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when destroy order_item success" do
      before do
        delete :destroy, params: {id: order_item.id}
      end

      it "will have flash success present" do
        expect(flash[:success]).to be_present
      end

      it "will redirect to cart_path" do
        expect(response).to redirect_to cart_path
      end
    end

    context "when destroy order_item failed" do
      before do
        allow_any_instance_of(Food).to receive(:destroy)
          .and_return(false)

        delete :destroy, params: {id: order_item.id}
      end

      it "will redirect to cart_path" do
        expect(response).to redirect_to cart_path
      end
    end
  end
end
