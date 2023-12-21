require 'rails_helper'
require 'spec_helper'

feature 'Shared' do
  let(:user) { User.create(username: 'test', email: 'test@email.com', password: 'password')}
  let(:deck) { Deck.create(name: 'test_deck', user: user)}

  before do 
    user
    deck #is this block messing things up? duplicate deck or something?
    sign_in(user) 
    click_on "Decks"
  end

  scenario "Unsuccessfully shares an empty deck" do
    user = create(:user)
    deck = create(:deck, user: user)
    click_on 'Share'
    expect(deck.shared).to eq(false)
  end

  scenario "Shares a new deck" do
    deck = create(:deck, user: user)
    flashcard = create(:flashcard, deck: deck)
    click_on 'Share'
    #here flashcard and deck return as valid, but deck does not become shared
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
    other_user = create(:user, username: 'other_user', email: 'other_user@example.com', password: 'password')
    other_deck = create(:deck, name: 'other_deck', user: other_user)
    flashcard = create(:flashcard, deck: other_deck)
    other_deck.update!(shared: true)

    click_on 'Get Shared Decks'
    fill_in 'Search a deck...', with: 'other_deck'
    click_button 'Search'
    click_on 'other_deck'
    click_on 'Add Deck'
    expect(user.decks.count).to eq(2)
  end
end