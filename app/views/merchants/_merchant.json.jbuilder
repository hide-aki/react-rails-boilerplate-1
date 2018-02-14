json.extract! merchant, :id, :hub_id, :name, :representative_name, :website, :created_at, :updated_at
json.url merchant_url(merchant, format: :json)
