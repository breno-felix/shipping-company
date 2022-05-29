class DeadlinesController < ApplicationController
  def index
    @carrier = Carrier.find(params[:carrier_id])
    @deadlines = Deadline.where(carrier_id: Carrier.find(params[:carrier_id]))
  end

  def new
    @deadline = Deadline.new
    calculate_initial_kilometer
    @carrier = Carrier.find(params[:carrier_id])
  end

  def create
    @carrier = Carrier.find(params[:carrier_id])
    deadline_params = params.require(:deadline).permit(:final_kilometer, :deadline)
    @deadline = Deadline.new(deadline_params)
    @deadline.initial_kilometer = calculate_initial_kilometer 
    carrier = Carrier.find(params[:carrier_id])
    @deadline.carrier = carrier
    if @deadline.save
      redirect_to new_carrier_deadline_path(carrier), notice: 'Prazo para intervalo de Km cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Prazo para intervalo de Km não cadastrado.'
      render 'new'
    end
  end

  private

  def calculate_initial_kilometer
    @deadlines = Deadline.where(carrier_id: Carrier.find(params[:carrier_id]))
    if @deadlines.any?
      @initial_kilometer = Deadline.last.final_kilometer
    else
      @initial_kilometer = 0
    end
  end 
end