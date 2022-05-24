class PricesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @prices = Price.where(carrier_id: Carrier.find(params[:carrier_id]))
    @price_kilometers = Kilometer.where(carrier_id: Carrier.find(params[:carrier_id]))
    @price_volumes = Volume.where(carrier_id: Carrier.find(params[:carrier_id]))
    @price_weights = Weight.where(carrier_id: Carrier.find(params[:carrier_id]))
    create_database
  end

  private

  def create_database
    if @prices.any?

    elsif @price_weights.any? && @price_volumes.any?
      @price_volumes.each do |v|
        @price_weights.each do |w|
          vi = v.initial_volume
          vf = v.final_volume
          wi = w.initial_weight
          wf = w.final_weight 
          pk = v.price_km + w.price_km
          Price.create!(initial_volume: vi, final_volume: vf, initial_weight: wi,
                        final_weight: wf, price_km: pk, carrier: @carrier)
        end
      end
    end
  end
end