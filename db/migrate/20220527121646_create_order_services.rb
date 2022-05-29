class CreateOrderServices < ActiveRecord::Migration[7.0]
  def change
    create_table :order_services do |t|
      t.string :search_address
      t.string :search_city
      t.string :search_state
      t.string :product_code
      t.integer :volume
      t.integer :weight
      t.string :delivery_address
      t.string :delivery_city
      t.string :delivery_state
      t.integer :distance
      t.integer :price
      t.integer :deadline
      t.string :name
      t.integer :cpf
      t.integer :status, default: 0
      t.references :carrier, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
