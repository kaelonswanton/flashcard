require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'averages the ratings of a flashcard' do
    user = User.create(username: 'test', email: "email@test.com", password: "password")
    deck = Deck.create(name: "Test Deck", user: user)
    flashcard = Flashcard.create(front: "Test Front", back: "Test Back", deck: deck)
    flashcard.reviews.create(difficulty: 2, user_id: user.id)
    flashcard.reviews.create(difficulty: 1, user_id: user.id)
    expect(flashcard.difficulty).to eq(1.5)
  end
end