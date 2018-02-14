class Merchant < ApplicationRecord
  belongs_to :user
  has_many :consignments

  # validation
  validates :name, presence: true, uniqueness: true
end
