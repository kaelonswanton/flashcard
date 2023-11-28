require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'averages the ratings of a flashcard' do
    expect(flashcard.average_rating).to eq(2)
  end
end