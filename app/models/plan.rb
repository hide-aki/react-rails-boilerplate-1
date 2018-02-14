class Plan < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: "created_by"
  belongs_to :user, class_name: 'User', foreign_key: "updated_by"

  # validation
  validates :name, :cost, presence: true
end
