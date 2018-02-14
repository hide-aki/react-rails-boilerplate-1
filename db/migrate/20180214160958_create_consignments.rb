class CreateConsignments < ActiveRecord::Migration[5.1]
  def change
    create_table :consignments do |t|
      t.integer :merchant_id
      t.integer :plan_id
      t.integer :current_hub_id
      t.integer :target_hub_id
      t.integer :rider
      t.integer :assigned_by
      t.integer :data_entry_by
      t.integer :completed_by # who add success status
      t.string :tracking_id, null: false
      t.string :receiver_name, null: false
      t.string :receiver_phone, null: false
      t.text :receiver_addr, null: false
      t.decimal :amount, precision: 8, scale: 2, default: 0, null: false
      t.float :weight
      t.decimal :charge, precision: 8, scale: 2, default: 0, null: false
      t.decimal :additional_cost, precision: 8, scale: 2, default: 0, null: false
      t.decimal :compensation, precision: 8, scale: 2, default: 0, null: false
      t.integer :payment_status, default: 0, null: false
      t.string :merchant_order_no
      t.string :package_description
      t.datetime :delivered_on
      t.datetime :assigned_on
      t.datetime :completed_on
      t.datetime :data_entry_on
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_index :consignments, :merchant_id
    add_index :consignments, :tracking_id, unique: true
    add_index :consignments, :rider
  end
end
