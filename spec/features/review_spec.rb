require 'rails_helper'
require 'spec_helper'

feature 'Review' do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
 
  scenario 'It creates a review on a flashcard' do
  end

  # before do
  #   sign_in(user)
  #   @card_one = create(:flashcard, deck: deck, front: 'Card 1', difficulty: 1)
  #   @card_two = create(:flashcard, deck: deck, front: 'Card 2', difficulty: 3)
  #   deck.flashcards << @card_one << @card_two
  #   click_on "Decks"
  #   click_on "Review"
  # end

  # scenario 'Card order changes depending on difficulty' do
  #   puts @card_one.inspect
  #   puts @card_two.inspect
  #   expect(page).to have_content('Card 2')
  #   click_on 'Easy'
  #   expect(page).to have_content('Card 1')
  # end
end