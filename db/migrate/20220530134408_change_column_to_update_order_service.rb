class ChangeColumnToUpdateOrderService < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:update_order_services, :msg_update, from: nil, to: "Pedido Aceito")
    change_column_default(:update_order_services, :latitude, from: nil, to: 0)
    change_column_default(:update_order_services, :longitude, from: nil, to: 0)
  end
end
