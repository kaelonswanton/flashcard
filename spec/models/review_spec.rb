require 'rails_helper'
require 'spec_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:flashcard) { create(:flashcard, deck: deck) }

  describe 'associations' do
    it { should belong_to(:flashcard).touch(true) }
    it { should belong_to(:user) }
  end

  it 'fetches flashcards ready for review' do
    flashcard = create(:flashcard, deck: deck)
    flashcard.update(updated_at: 1.month.ago, difficulty: 1.0)
    expect(flashcard.ready_for_review?).to eq(true)
  end

  it 'fetches NEW flashcards ready for review' do
    flashcard = create(:flashcard, deck: deck)
    expect(flashcard.new_flashcard?).to eq(true)
  end
end