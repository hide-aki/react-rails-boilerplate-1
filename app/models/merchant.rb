class Merchant < ApplicationRecord
  belongs_to :user
  has_many :consignments
  belongs_to :hub

  # validation
  validates :name, presence: true, uniqueness: true

  # Queries
  scope :newest_first, lambda { order("merchants.created_at DESC") }
end
