class WeightsController < ApplicationController
  def new
    @price = Weight.new
    calculate_initial_weight
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    price_params = params.require(:weight).permit(:final_weight, :price_km)
    @price = Weight.new(price_params)
    @price.initial_weight = calculate_initial_weight
    carrier = Carrier.find(params[:carrier_id])
    @price.carrier = carrier
    if @price.save
      redirect_to new_carrier_weight_path(carrier), notice: 'Preço para intervalo de peso cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Preço para intervalo de peso não cadastrado.'
      render 'new'
    end
  end

  private

  def calculate_initial_weight
    @price_weights = Weight.all
    if @price_weights.any?
      @initial_weight = Weight.last.final_weight
    else
      @initial_weight = 0
    end
  end  
end