require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:user) { User.create(username: 'test', email: 'test@example.com', password: 'password') }
  
  it 'is invalid without a name' do
    deck = Deck.new(name: nil)
    expect(deck).to_not be_valid
  end

  it 'is invalid with a duplicate name' do
    deck = Deck.create(name: 'test')
    deck2 = Deck.new(name: 'test')
    expect(deck2).to_not be_valid
  end

  it 'cannot be shared if empty' do
    deck = Deck.create(name: 'test', flashcards: [])
    deck.shared = true
    expect(deck).to_not be_valid
  end

  it 'can be shared if not empty' do
    deck = Deck.create(name: 'test', user: user, flashcards: [Flashcard.new(front: 'front', back: 'back')])
    deck.shared = true
    expect(deck).to be_valid
  end

  it 'cannot be shared if already shared' do
    deck = Deck.create(name: 'test', user: user, flashcards: [Flashcard.new(front: 'front', back: 'back')])
    deck.shared = true
    deck.save
    deck.shared = true
    expect(deck).to_not be_valid
  end
end
