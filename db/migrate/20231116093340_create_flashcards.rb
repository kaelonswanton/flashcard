class CreateFlashcards < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcards do |t|
      t.string :front
      t.string :back
      t.integer :difficulty
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
