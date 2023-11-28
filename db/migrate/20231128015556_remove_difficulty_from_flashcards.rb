class RemoveDifficultyFromFlashcards < ActiveRecord::Migration[7.0]
  def change
    remove_column :flashcards, :difficulty, :integer
  end
end
