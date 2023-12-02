require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'averages the ratings of a flashcard' do
    user = User.create(email: "email@test.com", password: "password")
    deck = Deck.create(name: "Test Deck", user_id: user.id)
    flashcard = Flashcard.create(front: "Test Front", back: "Test Back", deck_id: deck.id)
    puts flashcard.inspect
    flashcard.reviews.create(difficulty: 2, user_id: user.id)
    flashcard.reviews.create(difficulty: 1, user_id: user.id)
    puts flashcard.inspect
    expect(flashcard.difficulty).to eq(1.5)
  end


end