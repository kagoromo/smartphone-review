class Review < ApplicationRecord
  belongs_to :user
  belongs_to :device
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  is_impressionable counter_cache: true, column_name: :counter_cache,
    unique: :session_hash
    
  searchable do
    text :title
  end
end
