class CreateWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :weights do |t|
      t.integer :initial_weight
      t.integer :final_weight
      t.integer :price_km
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
