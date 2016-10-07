class Review < ApplicationRecord
  belongs_to :user
  belongs_to :device
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  is_impressionable counter_cache: true, column_name: :counter_cache
end
