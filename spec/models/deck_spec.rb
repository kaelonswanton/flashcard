require 'rails_helper'

RSpec.describe Deck, type: :model do
  it 'is invalid without a name' do
    deck = Deck.new(name: nil)
    expect(deck).to_not be_valid
  end

  it 'is invalid with a duplicate name' do
    deck = Deck.create(name: 'test')
    deck2 = Deck.new(name: 'test')
    expect(deck2).to_not be_valid
  end


end
