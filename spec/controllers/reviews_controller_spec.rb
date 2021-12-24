require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:user){ FactoryBot.create :user }
  let!(:admin){ FactoryBot.create :user, admin: true}
  let!(:order){ FactoryBot.create :order , user: user, status: 3}
  let!(:food1){ FactoryBot.create :food}
  let!(:food2){ FactoryBot.create :food}
  let!(:order_item1){ FactoryBot.create :order_item , user: user, order: order, food: food1}
  let!(:order_item2){ FactoryBot.create :order_item , user: user, order: order, food: food2}

  before do
    sign_in user
  end

  describe "GET #new" do
    before{get :new, params: {order: order.id}}

    it "Render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "With valid attributes" do
      before{post :create, params: {order_id: order.id, rate: 5, comment: Faker::String.random(length: [2, 100])}}

      it "order status = reviewed" do
        expect(assigns(:order).status).to eq("reviewed")
      end

      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "redirects to the userpath" do
        expect(response).to redirect_to user_path(user)
      end
    end
  end
end
