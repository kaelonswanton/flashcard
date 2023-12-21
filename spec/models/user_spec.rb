require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:decks).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }
    it { should have_many(:upvotes).class_name('Vote') }
    it { should have_many(:downvotes).class_name('Vote') }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end
end