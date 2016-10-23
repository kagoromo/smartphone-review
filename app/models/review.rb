class Review < ApplicationRecord
  belongs_to :user
  belongs_to :device

  has_many :comments, dependent: :destroy

  has_attached_file :cover_image,
    styles: { thumb: ["200x115#", :jpg], slideshow: ["800x400#", :jpg] },
    convert_options: { thumb: "-strip", slideshow: "-strip" },
    default_url: ":style/missing.png"

  validates :title, presence: true
  validates :content, presence: true
  validates :device_id, presence: true
  validates :summary, presence: true
  validates :the_good, presence: true
  validates :the_bad, presence: true
  validates :score_design, presence: true, inclusion: 1..10
  validates :score_screen, presence: true, inclusion: 1..10
  validates :score_performance, presence: true, inclusion: 1..10
  validates :score_battery, presence: true, inclusion: 1..10
  validates :score_camera, presence: true, inclusion: 1..10

  validates_attachment :cover_image,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  is_impressionable counter_cache: true, column_name: :counter_cache,
    unique: :session_hash

  enum status: [:pending, :approved, :rejected]

  scope :with_in_30_days, ->{ where('created_at > ?', 30.days.ago) }
end
