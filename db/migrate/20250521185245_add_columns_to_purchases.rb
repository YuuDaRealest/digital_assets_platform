class AddColumnsToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :total_amount, :decimal, precision: 10, scale: 2, null: false, default: 0
    add_column :purchases, :status, :string, null: false, default: 'completed'
  end
end 