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

end
