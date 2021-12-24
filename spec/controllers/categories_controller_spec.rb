require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:user){ FactoryBot.create :user, admin: true }
  let!(:category2){ FactoryBot.create :category }

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
      before{post :create, params: {category: FactoryBot.attributes_for(:category)}}

      it "creates a new category" do
        expect(assigns(:category)).to be_a Category
      end

      it "flash notice" do
        expect(flash[:notice]).to be_present
      end

      it "redirects to the new category" do
        expect(response).to redirect_to category_path(Category.last)
      end
    end
  end

  describe "GET /show" do
    context "when category subject not exist" do
      before{get :show, params: {id: -1}}

      it "flash danger category not found" do
        expect(flash[:danger]).to be_present
      end

      it "redirect to root page" do
        expect(response).to redirect_to root_url
      end
    end

    context "when category existed" do
      before{get :show, params: {id: category2.id}}

      it "will render template show" do
        expect(response).to render_template :show
      end

      it "will assign category to variable @category" do
        expect(assigns(:category)).to eq category2
      end
    end
  end
end
