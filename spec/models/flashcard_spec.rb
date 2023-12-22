require 'rails_helper'
RSpec.describe Flashcard, type: :model do
  let(:user) { build(:user) }
  let(:deck) { build(:deck, user: user) }
  let(:flashcard) { build(:flashcard, deck: deck) }

  describe 'associations' do
    it { should belong_to(:deck) }
    it { should have_one(:user).through(:deck) }
    it { should have_many(:reviews).dependent(:destroy) }
  end

  describe 'validations' do
    subject { flashcard }
    it { should validate_presence_of(:front) }
    it { should validate_length_of(:front).is_at_most(100) }
    it { should validate_uniqueness_of(:front).scoped_to(:deck_id) }
    it { should validate_presence_of(:back) }
    it { should validate_length_of(:back).is_at_most(100)}
  end

  it '#new_flashcard? sets the default rating to 4.0' do
    flashcard = create(:flashcard)
    expect(flashcard.difficulty).to eq(4.0)
  end

  it 'triggers #recalculate_difficulty after touching' do
    flashcard = create(:flashcard, deck: deck)
    flashcard.reviews.create(difficulty: 2, user: user)
    flashcard.reviews.create(difficulty: 1, user: user)
    expect(flashcard.difficulty).to eq(1.5)
  end

  it 'updates #ready_for_review?' do
    deck = create(:deck)
    2.times do
      flashcard = create(:flashcard, deck: deck)
    end
    ready_card = deck.flashcards.last
    ready_card.update(difficulty: 3.0, updated_at: Time.now - 1.day)
    expect(ready_card.ready_for_review?).to eq(true)

    unready_card = deck.flashcards.first
    unready_card.update(difficulty: 1.0, updated_at: Time.now)
    expect(unready_card.ready_for_review?).to eq(false)
  end

  it '#cannot_destroy_flashcard_when_deck_is_shared' do
    flashcard = create(:flashcard, deck: deck)
    deck.update(shared: true)
    flashcard.destroy
    expect(flashcard.persisted?).to eq(true)
  end
end