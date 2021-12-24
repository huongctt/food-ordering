require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category){ FactoryBot.create :category }
  
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
