class CreateUpdateOrderServices < ActiveRecord::Migration[7.0]
  def change
    create_table :update_order_services do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :order_service, null: false, foreign_key: true
      t.references :carrier, null: false, foreign_key: true
      t.text :msg_update
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
