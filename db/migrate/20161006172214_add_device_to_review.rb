class AddDeviceToReview < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :device, foreign_key: true
  end
end
