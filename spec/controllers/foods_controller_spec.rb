require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let!(:user){ FactoryBot.create :user , admin: true}
  let!(:food){ FactoryBot.create :food }

  before do
    sign_in user
  end

  describe "GET #new" do
    before{get :new}

    it "Render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "With valid attributes" do
      before{post :create, params: {food: FactoryBot.attributes_for(:food)}}

      it "creates a new food" do
        expect(assigns(:food)).to be_a Food
      end

      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "redirects to the root" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET /show" do
    context "when food subject not exist" do
      before{get :show, params: {id: -1}}

      it "flash danger food not found" do
        expect(flash[:danger]).to be_present
      end

      it "redirect to root page" do
        expect(response).to redirect_to root_url
      end
    end

    context "when food existed" do
      before{get :show, params: {id: food.id}}

      it "will render template show" do
        expect(response).to render_template :show
      end

      it "will assign course to variable @food" do
        expect(assigns(:food)).to eq food
      end
    end
  end

  describe "DELETE /destroy" do
    context "when not found food to destroy" do
      before do
        delete :destroy, params: {id: -1}
      end

      it "will redirect to root page" do
        expect(response).to redirect_to root_path
      end

      it "will have flash danger present" do
        expect(flash[:danger]).to be_present
      end
    end

    context "when destroy destroy success" do
      before do
        delete :destroy, params: {id: food.id}
      end

      it "will have flash success present" do
        expect(flash[:success]).to be_present
      end
    end

    context "when destroy food failed" do
      before do
        allow_any_instance_of(Food).to receive(:destroy)
          .and_return(false)

        delete :destroy, params: {id: food.id}
      end

      it "will have flash success present" do
        expect(flash[:notice]).to be_present
      end
    end
  end
end
