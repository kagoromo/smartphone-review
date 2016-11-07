class Device < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_attached_file :image,
    styles: { thumb: ["200x115", :jpg], default: ["225x400", :jpg] },
    convert_options: { thumb: "-strip", default: "-strip" },
    default_url: ":style/missing.png"

  validates :name, presence: true
  validates :screen, presence: true
  validates :chipset, presence: true
  validates :CPU, presence: true
  validates :GPU, presence: true
  validates :RAM, presence: true
  validates :OS, presence: true
  validates :main_camera, presence: true
  validates :sub_camera, presence: true
  validates :internal_memory, presence: true
  validates :external_memory, presence: true
  validates :battery, presence: true

  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
