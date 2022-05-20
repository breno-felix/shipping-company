class PricesController < ApplicationController
  def new
    @price = Price.new
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create
    price_params = params.require(:price).permit(:final_volume, :final_weight, :price_km)
    @price = Price.new(price_params)
    if @price.save
      @carrier = Carrier.find(params[:carrier_id])
      new_carrier_price_path(@carrier)
    else
      flash.now[:alert] = 'Fornecedor não cadastrado'
      render 'new'
    end
  end
end