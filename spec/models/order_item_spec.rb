require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let!(:order_item){ FactoryBot.create :order_item }
  
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:order) }
    it { should belong_to(:food) }
  end
end
