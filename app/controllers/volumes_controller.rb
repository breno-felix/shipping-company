class VolumesController < ApplicationController
  def new
    @price = Volume.new
    @price_volumes = Volume.all
    if @price_volumes.any?
      @initial_volume = Volume.last.final_volume + 1
    else

    end
  end

  def create
    price_volumes = Volume.all
    if price_volumes.any?
      initial_volume = Volume.last.final_volume + 1
    end

    carrier = Carrier.find(params[:carrier_id])
    price_params = params.require(:volume).permit(:final_volume, :price_km)
    price = Volume.new(price_params)
    price.initial_volume = initial_volume 
    price.carrier = carrier
    if price.save
      redirect_to new_carrier_volume_path(carrier), notice: 'Preço para intervalo de volume cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Preço para intervalo de volume não cadastrado.'
      render 'new'
    end
  end
end