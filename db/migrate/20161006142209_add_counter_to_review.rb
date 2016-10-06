class AddCounterToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :counter_cache, :integer, :default: 0
  end
end
