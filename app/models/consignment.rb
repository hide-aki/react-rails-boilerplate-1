class Consignment < ApplicationRecord
  belongs_to :merchant
  belongs_to :plan, optional: true
  belongs_to :hub, class_name: 'Hub', foreign_key: "current_hub_id", optional: true
  belongs_to :hub, class_name: 'Hub', foreign_key: "target_hub_id", optional: true
  belongs_to :user, class_name: 'User', foreign_key: "rider", optional: true
  belongs_to :user, class_name: 'User', foreign_key: "assigned_by", optional: true
  belongs_to :user, class_name: 'User', foreign_key: "data_entry_by", optional: true
  belongs_to :user, class_name: 'User', foreign_key: "completed_by", optional: true

  # validation
  validates :merchant_id, :tracking_code, :receiver_name, :receiver_phone, :receiver_addr, presence: true
  validates :tracking_code, uniqueness: true
  validates :receiver_phone, length: {minimum: 11, maximum: 14}

  # Queries
  scope :newest_first, lambda { order("consignments.created_at DESC") }

  # Set receiver payment status value
  enum payment_status: { given: 1, not_yet: 2 }

  # Set Consignments status value
  enum status: { success: 1, delivered: 2, not_delivered: 3, due: 4 }

end