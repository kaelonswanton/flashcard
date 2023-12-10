class AddSharedToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :shared, :boolean, default: false
  end
end
