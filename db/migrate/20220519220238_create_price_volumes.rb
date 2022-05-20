class CreatePriceVolumes < ActiveRecord::Migration[7.0]
  def change
    create_table :price_volumes do |t|
      t.integer :initial_volume, default: 0
      t.integer :final_volume
      t.integer :price
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
