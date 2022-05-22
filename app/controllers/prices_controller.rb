class PricesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @price_volumes = Volume.where(carrier_id: Carrier.find(params[:carrier_id]))
    @price_weights = Weight.where(carrier_id: Carrier.find(params[:carrier_id]))
    @price_kilometers = Kilometer.where(carrier_id: Carrier.find(params[:carrier_id]))
  end

end