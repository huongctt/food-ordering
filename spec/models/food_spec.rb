require 'rails_helper'

RSpec.describe Food, type: :model do
  let!(:food){ FactoryBot.create :food }

  describe "Associations" do
    it { should belong_to(:category) }
  end
  
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_length_of(:description)
      .is_at_most(Settings.maximum_length_description) }
    it { is_expected.to validate_length_of(:description)
      .is_at_least(Settings.minimum_length_description) }
  end
end
