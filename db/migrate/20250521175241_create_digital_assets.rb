class CreateDigitalAssets < ActiveRecord::Migration[8.0]
  def change
    create_table :digital_assets do |t|
      t.string :title
      t.text :description
      t.string :file_url
      t.decimal :price
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
