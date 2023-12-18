require 'rails_helper'
require 'spec_helper'

feature 'Flashcard' do
  let(:user) { User.create(username: 'test', email: 'test@example.com', password: 'password') }
  let!(:deck) { Deck.create(name: 'test', user: user) }
  let!(:flashcard) { Flashcard.create(front: 'front', back: 'back', deck: deck) }

  before do
    sign_in(user)
    click_on "Decks"
  end

  scenario "Creates a new flashcard" do
    click_link 'Add'
    select 'test', from: 'Deck'
    fill_in 'Front', with: 'test'
    fill_in 'Back', with: 'test'
    click_button 'Add'
    expect(page).to have_content('Flashcard added successfully!')
  end

  scenario 'Edits a flashcard' do
    click_on 'test'
    find('summary', text: 'Actions').click # click on dropdown menu
    click_on 'Edit Flashcard'
    fill_in 'Front', with: 'test1'
    fill_in 'Back', with: 'test1'
    click_button 'Update'
    expect(page).to have_content('Flashcard updated successfully!')
  end

  scenario 'Deletes a flashcard' do
    click_on 'test'
    find('summary', text: 'Actions').click # click on dropdown menu
    click_on 'Delete'
    expect(page).to have_content('Flashcard deleted successfully!')
  end
end