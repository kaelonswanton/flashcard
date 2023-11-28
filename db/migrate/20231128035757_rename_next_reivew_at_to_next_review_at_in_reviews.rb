class RenameNextReivewAtToNextReviewAtInReviews < ActiveRecord::Migration[7.0]
  def change
    rename_column :reviews, :next_reivew_at, :next_review_at
  end
end
