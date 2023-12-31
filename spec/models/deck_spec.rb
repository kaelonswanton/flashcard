require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:user) { build(:user) }
  let(:deck) { build(:deck, user: user) }
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:flashcards).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe 'validations' do
    subject { deck }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
  end

  it 'cannot be shared if empty' do
    deck.flashcards = []
    deck.shared = true
    expect(deck).to_not be_valid
  end

  it 'can be shared if not empty' do
    deck.flashcards << build(:flashcard)
    deck.shared = true
    expect(deck).to be_valid
  end

  it 'cannot be shared if already shared' do
    deck.shared = true
    deck.save
    deck.shared = true
    expect(deck).to_not be_valid
  end

  it 'counts #deck_score' do
    deck = create(:deck, user: user)
    deck.votes << Vote.create(type: "Upvote", user: user, deck: deck)
    expect(deck.vote_score).to eq(1)
  end
end
