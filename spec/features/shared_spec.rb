require 'rails_helper'
require 'spec_helper'

feature 'Shared' do

  before do 
    user = create(:user)
    sign_in(user) 
    click_on "Decks"
  end

  scenario "Shares a new deck" do
    deck = create(:deck, user: user)
    click_on 'Share'
    expect(page).to have_content('Deck shared successfully!')
  end

  scenario 'Unshares a deck' do
  end

  scenario 'Gets a shared deck' do
  end

end