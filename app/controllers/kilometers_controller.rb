class KilometersController < ApplicationController
  def new
    @price = Kilometer.new
    calculate_initial_kilometer
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    price_params = params.require(:kilometer).permit(:final_kilometer, :price_km)
    @price = Kilometer.new(price_params)
    @price.initial_kilometer = calculate_initial_kilometer 
    carrier = Carrier.find(params[:carrier_id])
    @price.carrier = carrier
    if @price.save
      redirect_to new_carrier_kilometer_path(carrier), notice: 'Preço Mínimo para intervalo de Km cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Preço Mínimo para intervalo de Km não cadastrado.'
      render 'new'
    end
  end

  private

  def calculate_initial_kilometer
    @price_kilometers = Kilometer.where(carrier_id: Carrier.find(params[:carrier_id]))
    if @price_kilometers.any?
      @initial_kilometer = Kilometer.last.final_kilometer
    else
      @initial_kilometer = 0
    end
  end 
end
