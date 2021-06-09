class ChangeDatatypeScoreOfReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :score, :float
  end
end
