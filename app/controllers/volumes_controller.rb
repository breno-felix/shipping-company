class VolumesController < ApplicationController
  def new
    @price = Volume.new
    calculate_initial_volume
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    price_params = params.require(:volume).permit(:final_volume, :price_km)
    @price = Volume.new(price_params)
    @price.initial_volume = calculate_initial_volume 
    carrier = Carrier.find(params[:carrier_id])
    @price.carrier = carrier
    if @price.save
      update_database
      redirect_to new_carrier_volume_path(carrier), notice: 'Preço para intervalo de volume cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Preço para intervalo de volume não cadastrado.'
      render 'new'
    end
  end

  private

  def calculate_initial_volume
    @price_volumes = Volume.where(carrier_id: Carrier.find(params[:carrier_id]))
    if @price_volumes.any?
      @initial_volume = Volume.last.final_volume
    else
      @initial_volume = 0
    end
  end
  
  def update_database
    @price_weights = Weight.where(carrier_id: Carrier.find(params[:carrier_id]))
    if @price_weights.any?
      v = Volume.last
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