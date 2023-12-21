require 'rails_helper'
RSpec.describe Vote, type: :model do
  let (:vote) { build(:vote) }
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:deck) }
  end

  describe 'validations' do
    subject { vote }
    it { should validate_uniqueness_of(:user_id).scoped_to(:deck_id) }
  end
end