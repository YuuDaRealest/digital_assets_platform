class CreatePurchaseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_items do |t|
      t.references :purchase, null: false, foreign_key: true
      t.references :digital_asset, null: false, foreign_key: true
      t.decimal :price_at_purchase

      t.timestamps
    end
  end
end
