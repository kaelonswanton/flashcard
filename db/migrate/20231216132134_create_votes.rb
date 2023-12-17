class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
