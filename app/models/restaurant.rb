class Restaurant < ApplicationRecord
  CATEGORIES = ["Thai", "Mexican", "American", "Vietnamese", "Peruvian"].sort
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
