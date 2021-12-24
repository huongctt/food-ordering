require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:user){ FactoryBot.create :user }
  let!(:admin){ FactoryBot.create :user, admin: true}
  let!(:order){ FactoryBot.create :order , user: user, status: 0}
  let!(:order1){ FactoryBot.create :order , user: user, status: 1}

  describe "GET /show" do
    before do
      sign_in user
      get :show, params: {id: order.id}
    end
    context "when order existed" do
      # before{get :show, params: {id: order.id}}

      it "will render template show" do
        expect(response).to render_template :show
      end

      it "will assign course to variable @order" do
        expect(assigns(:order)).to eq order
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in user
      get :edit, params: {id: order.id}
    end
    # before{get :edit, params: {id: order.id}}

    it "Render edit template" do
      expect(response).to render_template :edit
    end

    it "will assign course to variable @order" do
      expect(assigns(:order)).to eq order
    end
  end

  describe "PATCH #update" do
  before do
    sign_in user
    patch :update, params: {id: order.id, order: {id: order.id, address: "aaaaaaa", order_time: Time.now, status: 'created'}}
  end
    context "With valid attributes" do
      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "order status = created" do
        expect(assigns(:order).status).to eq("created")
      end

      it "redirects to the root" do
        expect(response).to redirect_to user_path(user)
      end
    end
  end

  describe "POST #accept" do
    before do
      sign_in admin
      post :accept, params: {id: order1.id, status: 'accepted'}
    end
    context "With valid attributes" do
      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "order status = accepted" do
        expect(assigns(:order).status).to eq("accepted")
      end

      it "redirects to the root" do
        expect(response).to redirect_to orders_path
      end
    end
  end

  describe "POST #confirm" do
    before do
      sign_in user
      post :confirm, params: {id: order1.id, status: 'confirmed'}
    end
    context "With valid attributes" do
      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "order status = confirmed" do
        expect(assigns(:order).status).to eq("confirmed")
      end

      it "redirects to the root" do
        expect(response).to redirect_to user_path(user)
      end
    end
  end
end
