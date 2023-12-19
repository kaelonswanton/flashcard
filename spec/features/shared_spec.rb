require 'rails_helper'
require 'spec_helper'

feature 'Shared' do
  let(:user) { User.create(username: 'test', email: 'test@email.com', password: 'password')}
  let(:deck) { Deck.create(name: 'test_deck', user: user)}

  before do 
    user
    deck
    sign_in(user) 
    click_on "Decks"
  end

  scenario "Unsuccessfully shares an empty deck" do
    click_on 'Share'
    expect(page).to have_content("Deck cannot be empty!")
  end

  scenario "Shares a new deck" do
    deck = create(:deck, user: user)
    click_on 'Share'
    expect(page).to have_content('Deck shared successfully!')
  end

  scenario 'Unshares a deck' do
   pending 'incomplete'
   raise 'In Progress'
  end

  scenario 'Gets a shared deck' do
    pending 'incomplete'
    raise 'In Progress2'
  end

end