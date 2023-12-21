require 'rails_helper'
require 'spec_helper'

feature 'Review' do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
 
  scenario 'It creates a review on a flashcard after reviewing' do
    flashcard = create(:flashcard, deck: deck)
    sign_in(user)
    click_on "Decks"
    click_on 'Review'
    click_on 'Easy'
    expect(user.reviews.count).to eq(1)
    expect(flashcard.reload.difficulty).to eq(1)
  end
end