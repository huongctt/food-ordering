require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review){ FactoryBot.create :review }

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:food) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:rate) }
    it { is_expected.to validate_length_of(:comment)
      .is_at_most(Settings.maximum_length_comment) }
  end
end
