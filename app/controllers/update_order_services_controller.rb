class UpdateOrderServicesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @order_services = OrderService.where(carrier_id: Carrier.find(params[:carrier_id]))
  end

  def new
    @carrier = Carrier.find(params[:carrier_id])
    @code = params[:code]
    @order_service = OrderService.find_by(code: @code)
    @order_service_id = @order_service.id
    @vehicles = Vehicle.where(carrier_id: @carrier)
    @update_order_services = UpdateOrderService.includes(:order_service).where(order_service: {code: @code})
    @vehicle_id = @update_order_services.last
    @update_order_service = UpdateOrderService.new
  end

  def create
    @update_order_services = UpdateOrderService.includes(:order_service).where(order_service: {code: @code})
    
    if @update_order_services.any?
      update_order_service_params = params.require(:update_order_service).permit(:msg_update, :latitude,
                                                                                 :longitude, :order_service_id,
                                                                                 :vehicle_id)
    else
      update_order_service_params = params.require(:update_order_service).permit(:vehicle_id,
                                                                                 :order_service_id)
    end
      @update_order_service = UpdateOrderService.new(update_order_service_params)
      carrier = Carrier.find(params[:carrier_id])
      @update_order_service.carrier = carrier
    
    if @update_order_service.save
      if @update_order_services.any?
        redirect_to search_order_carrier(carrier)
      else
        redirect_to carrier_update_order_services_path(carrier)
      end
    else
      render 'new'
    end
  end
end