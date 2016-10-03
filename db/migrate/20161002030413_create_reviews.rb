class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
