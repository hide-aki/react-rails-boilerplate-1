class Consignment < ApplicationRecord
  belongs_to :merchant
  belongs_to :plan, optional: true
  belongs_to :hub, class_name: 'Hub', foreign_key: "current_hub_id", optional: true
  belongs_to :hub, class_name: 'Hub', foreign_key: "target_hub_id", optional: true
  belongs_to :user, class_name: 'User', foreign_key: "rider"
  belongs_to :user, class_name: 'User', foreign_key: "assigned_by"
  belongs_to :user, class_name: 'User', foreign_key: "data_entry_by"
  belongs_to :user, class_name: 'User', foreign_key: "completed_by"

  # Set receiver payment status value
  enum payment_status: { given: 1, not_yet: 2 }

  # Set Consignments status value
  enum status: { success: 1, delivered: 2, not_delivered: 3, due: 4 }
end