class VehiclesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @vehicles = Vehicle.where(carrier_id: Carrier.find(params[:carrier_id]))
  end

  def new
    @vehicle = Vehicle.new
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create  
    vehicle_params = params.require(:vehicle).permit(:brand, :model, :year, :plate, :capacity)
    @vehicle = Vehicle.new(vehicle_params)
    @carrier = Carrier.find(params[:carrier_id])
    @vehicle.carrier = @carrier
    if @vehicle.save
      redirect_to carrier_vehicles_path(@carrier), notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Veículo não cadastrado.'
      render 'new'
    end
  end
end