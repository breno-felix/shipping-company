class OrderServicesController < ApplicationController
  def new
    @order_service = OrderService.new
    @volume = params["volume"].to_i
    @weight = params["weight"].to_i
    @distance = params["distance"].to_i
    @price = params["price"].to_i
    @deadline = params["deadline"].to_i
    
  end

  def create
    order_service_params = params.require(:order_service).permit(:search_address,
                           :search_city, :search_state, :product_code, :volume,
                           :weight, :delivery_address, :delivery_city, :delivery_state,
                           :distance, :price, :deadline, :name, :cpf)
    @order_service = OrderService.new(order_service_params)
    carrier = Carrier.find(params[:carrier_id])
    @order_service.carrier = carrier
    if @order_service.save
      redirect_to order_services_path, notice: 'Ordem de Serviço cadastrada com sucesso.'
    else
      flash.now[:alert] = 'Ordem de Serviço não cadastrada.'
      render 'new'
    end
  end

  def index
    @order_services = OrderService.all
  end

  def edit
    @carrier = Carrier.find(params[:carrier_id])
    @order_service = OrderService.find(params[:id])
    @vehicles = Vehicle.where(carrier_id: @carrier)
  end

  def update
    @carrier = Carrier.find(params[:carrier_id])
    @order_service = OrderService.find(params[:id])

    order_service_params = params.require(:order_service).permit(:vehicle_id)

    if @order_service.update(order_service_params)
      @order_service.accepted!
      redirect_to carrier_update_order_services_path(@carrier), notice: 'Ordem de serviço aceita com sucesso'
    else
      flash.now[:notice] = "Erro!"
      render 'edit'
    end
  end

  def refused
    carrier = Carrier.find(params[:carrier_id])
    order_service = OrderService.find(params[:id])
    order_service.refused!
    redirect_to carrier_update_order_services_path(carrier), notice: 'Ordem de serviço recusada com sucesso'
  end

  def finished
    carrier = Carrier.find(params[:carrier_id])
    order_service = OrderService.find(params[:id])
    order_service.finished!
    redirect_to search_carrier_update_order_services_path(carrier), notice: 'Ordem de serviço finalizada com sucesso'
  end
end
