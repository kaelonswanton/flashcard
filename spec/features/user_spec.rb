require 'spec_helper'

feature 'User' do
  scenario "logs in and creates a deck and flashcard" do
    user = create(:user)

    visit root_path
    click_link 'Log In'
    fill_in 'Email' with: user.email
    fill_in 'Password' with: user.password
    click_button 'Log in'
    #fix hte delete button on decks
    expect {
      click_link 'Decks'
      fill_in 'Create' with: 'test'
      click_button 'Create'
    }.to change(Deck, :count).by(1)
  end
end