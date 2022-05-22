class CreateKilometers < ActiveRecord::Migration[7.0]
  def change
    create_table :kilometers do |t|
      t.integer :initial_kilometer, default: 0
      t.integer :final_kilometer
      t.integer :price_km
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
