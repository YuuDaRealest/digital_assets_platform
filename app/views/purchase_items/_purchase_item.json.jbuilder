json.extract! purchase_item, :id, :purchase_id, :digital_asset_id, :price_at_purchase, :created_at, :updated_at
json.url purchase_item_url(purchase_item, format: :json)
