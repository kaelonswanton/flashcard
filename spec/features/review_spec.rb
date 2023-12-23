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

  scenario 'It only fetches flashcards ready for review' do
    sign_in(user)
    create(:flashcard, deck: deck, front: 'card_one')
    click_on "Decks"
    click_on 'Review'
    click_on 'Easy'
    expect(page).to have_content('Review Complete!')
    create(:flashcard, deck: deck, updated_at: 1.month.ago, difficulty: 3.0, front: 'card_two')
    create(:flashcard, deck: deck, difficulty: 4.0, front: 'card_three')
    click_on 'Review'
    expect(page).to have_content('card_two')
    click_on 'Easy'
    expect(page).to have_content('card_three')
    click_on 'Easy'
    expect(page).to have_content('Review Complete!')
  end
end