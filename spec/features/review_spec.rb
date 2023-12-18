require 'rails_helper'
require 'spec_helper'

feature 'Review' do
  let(:user) { User.create(username: 'test', email: 'test@example.com', password: 'password') }
  let!(:deck) { Deck.create(name: 'test') }

  before do
    sign_in(user)
    click_on "Decks"
    click on "Review"
  end

  scenario 'Reviews a deck' do
  end



end