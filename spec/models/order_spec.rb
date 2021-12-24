require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order){ FactoryBot.create :order }

  describe "Associations" do
    it { should have_many(:order_items).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe "enums" do
    context "status" do
      it do
        should define_enum_for(:status).with(
          declined: -1, init: 0, created: 1, accepted: 2, confirmed: 3, reviewed: 4
        )
      end
    end
  end
end
