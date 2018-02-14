class Plan < ApplicationRecord
  has_many :consignments
  belongs_to :user, class_name: 'User', foreign_key: "created_by"
  belongs_to :user, class_name: 'User', foreign_key: "updated_by"

  # validation
  validates :name, presence: true, uniqueness: true
  validates :cost, presence: true
end
