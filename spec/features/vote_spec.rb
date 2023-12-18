feature "Votes on a new deck" do
  let(:user) { User.create(username: 'test', email: 'test@example.com', password: 'password') }

  scenario "Votes on a new deck" do
    user2 = User.create(username: 'user2', email: 'user2@example.com', password: 'password')
    deck2 = Deck.new(name: 'public', user: user2, shared: true)
    deck2.flashcards.build(front: 'front', back: 'back')
    deck2.save
    click_on 'Get Shared Decks'
    fill_in 'Search a deck...', with: 'public'
    click_button 'Search'
    click_on 'public'
    click_button 'upvote' #rspec will view this as a GET instead of a POST
    expect(user.upvotes.count).to eq(1)
  end