class RemoveUniqueIndexFromDecksName < ActiveRecord::Migration[7.0]
  def change
    remove_index :decks, :name
    add_index :decks, :name
  end
end
