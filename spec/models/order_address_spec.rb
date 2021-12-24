require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let!(:order_address){ FactoryBot.create :order_address}

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:address) }
  end
end
