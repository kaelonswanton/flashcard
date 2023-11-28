class RenameRatingToAverageRatingInReviews < ActiveRecord::Migration[7.0]
  def change
    rename_column :reviews, :rating, :average_rating
  end
end
