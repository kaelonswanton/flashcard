require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  it 'is invalid without a front' do
    flashcard = build(:flashcard, front: nil)
    flashcard.valid?
    expect(flashcard.errors[:front]).to include("can't be blank")
  end

  it 'is invalid without a back' do
    flashcard = build(:flashcard, back: nil)
    flashcard.valid?
    expect(flashcard.errors[:back]).to include("can't be blank")
  end

  it 'is invalid with a duplicate front' do
    flashcard = create(:flashcard, front: 'front')
    flashcard2 = build(:flashcard, front: 'front', user: flashcard.user, deck: flashcard.deck )
    flashcard2.valid?
    expect(flashcard2.errors[:front]).to include("has already been taken")
  end

  it 'is invalid with a duplicate back' do
    flashcard = create(:flashcard, back: 'back')
    flashcard2 = build(:flashcard, back: 'back', user: flashcard.user, deck: flashcard.deck )
    flashcard2.valid?
    expect(flashcard2.errors[:back]).to include("has already been taken")
  end
end
