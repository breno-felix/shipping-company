class UpdateOrderServicesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @order_services = OrderService.where(carrier_id: Carrier.find(params[:carrier_id]))
  end
end