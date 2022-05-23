class AddCarrierToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :carrier, null: false, foreign_key: true
  end
end
