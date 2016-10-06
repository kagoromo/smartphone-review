class Device < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
