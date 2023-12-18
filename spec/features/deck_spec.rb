require 'rails_helper'
require 'spec_helper'

feature 'Deck' do
  let(:user) { User.create(username: 'test', email: 'test@example.com', password: 'password') }
  let!(:deck) { Deck.create(name: 'test', user: user) }
  before do 
    sign_in(user) 
    click_on "Decks"
  end

  scenario "Creates a new deck" do
    fill_in 'Enter new deck name', with: 'example'
    click_button 'Create'
    expect(page).to have_content('Deck created successfully!')
  end

  scenario "Edits a new deck" do
    click_on 'Edit name'
    fill_in 'Enter new deck name', with: 'test1'
    click_on 'Update'
    expect(page).to have_content('Deck updated successfully!')
    expect(page).to have_content('test1')
  end

  scenario "Deletes a new deck" do
    click_on 'Delete'
    expect(page).to have_content('Deck deleted successfully!')
  end
end