class UpdateOrderServicesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @order_services = OrderService.where(carrier_id: Carrier.find(params[:carrier_id]))
  end

  def new
    @carrier = Carrier.find(params[:carrier_id])
    @order_service = OrderService.find_by(code: params[:code])
    @update_order_service = UpdateOrderService.new
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    update_order_service_params = params.require(:update_order_service).permit(:msg_update, :latitude,
                                                                               :longitude, :order_service_id)
    @update_order_service = UpdateOrderService.new(update_order_service_params)    
    if @update_order_service.save
      redirect_to search_carrier_update_order_services_path(@carrier), notice: 'Atualização registrada com sucesso'
    else
      flash.now[:alert] = 'Atualização não registrada'
      render 'new'
    end
  end

  def search
    @carrier = Carrier.find(params[:carrier_id])
    @code = params["code"]
    @order_service = OrderService.find_by(code: @code)
    @update_order_services = UpdateOrderService.includes(:order_service).where(order_service: {code: @code})
  end
end