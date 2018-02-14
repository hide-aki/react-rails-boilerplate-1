class Hub < ApplicationRecord
  has_many :consignments
  belongs_to :user, class_name: 'User', foreign_key: "created_by"
  belongs_to :user, class_name: 'User', foreign_key: "updated_by"

  # validation
  validates :name, presence: true, uniqueness: true

  # Query scope
  scope :newest_first, lambda { order("hubs.created_at DESC") }
end
