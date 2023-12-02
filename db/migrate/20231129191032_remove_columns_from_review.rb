class RemoveColumnsFromReview < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :average_rating, :datatype
    remove_column :reviews, :next_review_at, :datatype
  end
end
