json.extract! digital_asset, :id, :title, :description, :file_url, :price, :creator_id, :created_at, :updated_at
json.url digital_asset_url(digital_asset, format: :json)
