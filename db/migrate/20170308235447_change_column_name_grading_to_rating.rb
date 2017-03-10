class ChangeColumnNameGradingToRating < ActiveRecord::Migration[5.0]
  def change
    rename_column :reviews, :grading, :rating
  end
end
