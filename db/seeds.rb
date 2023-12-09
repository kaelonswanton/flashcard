# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Faker code that will create 25 users, 25 decks, 25 cards each.
25.times do |i|
  user = User.create(
    username: "#{Faker::Internet.username}#{i}",
    email: "#{Faker::Internet.email}#{i}",
    password: Faker::Internet.password
  )

  25.times do |j|
    deck = Deck.create(
      name: "#{Faker::Lorem.sentence(word_count: 3)}#{i}_#{j}",
      user: user
    )

    25.times do |k|
      Flashcard.create(
        front: "#{Faker::Lorem.question(word_count: 5)}#{i}_#{j}_#{k}",
        back: Faker::Lorem.sentence(word_count: 7),
        deck_id: deck.id
      )
    end
  end
end