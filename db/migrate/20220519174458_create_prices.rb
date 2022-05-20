class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :initial_volume, default: 0
      t.integer :final_volume
      t.integer :initial_weight, default: 0
      t.integer :final_weight
      t.integer :price_km
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
