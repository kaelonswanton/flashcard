require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  let(:deck) { build(:deck) }
  let(:user) { build(:user) }

  it 'is invalid without a front' do
    flashcard = build(:flashcard, front: '')
    expect(flashcard).to_not be_valid
  end

  it 'is invalid without a back' do
    flashcard = build(:flashcard, back: nil)
    expect(flashcard).to_not be_valid
  end

  it 'is invalid with a duplicate front in the same deck' do
    create(:flashcard, front: 'front', deck: deck)
    flashcard2 = build(:flashcard, front: 'front', deck: deck)
    expect(flashcard2).to_not be_valid
  end

  it 'is valid with a duplicate back in the same deck' do
    #deck
    flashcard = create(:flashcard, back: 'back', deck: deck)
    flashcard2 = build(:flashcard, back: 'back', deck: deck)
    expect(flashcard2).to be_valid
  end

  it 'triggers #recalculate_difficulty after touching' do
    # deck
    # user
    flashcard = create(:flashcard, deck: deck)
    flashcard.reviews.create(difficulty: 2, user: user)
    flashcard.reviews.create(difficulty: 1, user: user)
    expect(flashcard.difficulty).to eq(1.5)
  end

  it 'updates #ready_for_review?' do
    deck = create(:deck)
    5.times do
      flashcard = create(:flashcard, deck: deck)
    end
    ready_card = deck.flashcards.last
    ready_card.update(difficulty: 3.0, updated_at: Time.now - 1.day)
    expect(ready_card.ready_for_review?).to eq(true)

    unready_card = deck.flashcards.first
    unready_card.update(difficulty: 1.0, updated_at: Time.now)
    expect(unready_card.ready_for_review?).to eq(false)
  end
end
