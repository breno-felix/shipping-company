class RemoveVehicleAndCarrierFromUpdateOrderServices < ActiveRecord::Migration[7.0]
  def change
    remove_reference :update_order_services, :vehicle, null: false, foreign_key: true
    remove_reference :update_order_services, :carrier, null: false, foreign_key: true
  end
end
