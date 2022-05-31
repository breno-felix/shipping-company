class CarriersController < ApplicationController
  def show
    @carrier = Carrier.find(params[:id])
  end

  def new
    @carrier = Carrier.new
  end

  def create
    carrier_params = params.require(:carrier).permit(:corporate_name, :brand_name,
                                                      :registration_number, :full_address,
                                                      :city, :state, :email_domain)
    @carrier = Carrier.new(carrier_params)
    if @carrier.save
      redirect_to @carrier, notice: 'Transportadora cadastrada com sucesso'
    else
      flash.now[:alert] = 'Transportadora não cadastrada'
      render 'new'
    end
  end

  def disabled
    @carrier = Carrier.find(params[:id])
    @carrier.disabled!
    redirect_to @carrier
  end

  def enabled
    @carrier = Carrier.find(params[:id])
    @carrier.enabled!
    redirect_to @carrier
  end

  def budget
    @height = params["height"].to_i
    @width = params["width"].to_i
    @depth = params["depth"].to_i
    @weight = params["weight"].to_i
    @distance = params["distance"].to_i
    @volume = volume

    @prices = Price.includes(:carrier).where(carrier: {status: "enabled"}).where("initial_volume < :volume AND
                          final_volume >= :volume AND initial_weight < :weight AND final_weight >= :weight", 
                          {volume: @volume, weight: @weight})
    @distances = Kilometer.where("initial_kilometer < :distance AND final_kilometer >= :distance", 
                          {distance: @distance})
    @deadlines = Deadline.where("initial_kilometer < :distance AND final_kilometer >= :distance", 
                          {distance: @distance})

    @count = @prices.count

  end

  def search_order
    @carrier = Carrier.find(params[:id])
    @code = params["code"]
    @order_service = OrderService.find_by(code: @code)
    @update_order_services = UpdateOrderService.includes(:order_service).where(order_service: {code: @code})
    
  end

  private

  def volume
    @height * @width * @depth
  end

end
