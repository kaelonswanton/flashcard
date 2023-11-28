require 'rails_helper'
require 'spec_helper'

feature 'User' do
  scenario "Creates, edits, and deletes a deck" do
    user = create(:user)
    sign_in(user)
    click_link 'Decks'
    fill_in 'Enter new deck name', with: 'test'
    click_button 'Create'
    click_link 'Edit name'
    fill_in 'Enter new deck name', with: 'test1'
    click_button 'Update'
    expect(page).to have_content('Deck updated successfully!')
    click_button 'Delete'
    expect(page).to have_content('Deck deleted successfully!')
  end

  scenario "Adds a flashcard, edits name, then deletes it from deck" do
    user = create(:user)
    sign_in(user)
    create(:deck, name: 'test', user: user)
    click_link 'Create Flashcard'
    select 'test', from: 'Deck'
    fill_in 'Front', with: 'front'
    fill_in 'Back', with: 'back'
    click_button 'Add'
    expect(page).to have_content('Flashcard added successfully!')
    click_link 'Decks'
    click_link 'test'
    click_link 'Edit Flashcard'
    fill_in 'Front', with: 'front1'
    fill_in 'Back', with: 'back1'
    click_button 'Update'
    expect(page).to have_content('Flashcard updated successfully!')
    click_link 'test'
    click_button 'Delete'
    expect(page).to have_content('Flashcard deleted successfully!')
  end
end