require 'rails_helper'
require 'spec_helper'

feature 'Shared' do
  let(:user) { User.create(username: 'test', email: 'test@email.com', password: 'password')}
  let(:deck) { Deck.create(name: 'test_deck', user: user)}
  let(:flashcard) { Flashcard.create!(front: 'test_front', back: 'test_back', deck: deck) }

  before do 
    user
    deck
    flashcard
    sign_in(user) 
    click_on "Decks"
  end

  scenario "Unsuccessfully shares an empty deck" do
    deck.flashcards.destroy_all
    deck.reload
    click_button 'Share'
    expect(page).to have_content("Deck cannot be shared if empty.")
  end

  scenario "Shares a new deck" do
    click_button 'Share'
    deck.reload
    expect(deck.shared).to eq(true)
    expect(page).to have_content('Deck shared successfully!')
  end

  scenario 'Unshares a deck' do
    deck = create(:deck, user: user)
    flashcard = create(:flashcard, deck: deck)
    deck.update!(shared: true)
    click_on 'My Shared Decks'
    click_on 'Remove'
    expect(page).to have_content('Deck unshared successfully!')
  end

  scenario 'Gets a shared deck' do
    other_user = User.create!(username: 'other_user', email: 'other_user@example.com', password: 'password')
    other_deck = Deck.create!(name: 'other_deck', user: other_user)
    flashcard = create(:flashcard, deck: other_deck)
    other_deck.update!(shared: true)

    click_on 'Get Shared Decks'
    fill_in 'Search a deck...', with: 'other_deck'
    click_button 'Search'
    click_on 'other_deck'
    click_on 'Add Deck'
    expect(page).to have_content('Deck duplicated successfully!')
  end
end