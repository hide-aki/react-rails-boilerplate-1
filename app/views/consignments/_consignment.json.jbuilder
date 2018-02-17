json.extract! consignment, :id, :merchant_id, :plan_id, :tracking_code, :receiver_name, :receiver_phone, :receiver_addr, :price, :weight, :charge, :additional_cost, :compensation, :payment_status, :merchant_order_no, :package_description, :delivered_on, :created_at, :updated_at
json.url consignment_url(consignment, format: :json)
