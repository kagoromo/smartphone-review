class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :phones
end
