class OrderService < ApplicationRecord
  belongs_to :carrier
  belongs_to :vehicle, optional: true
  
  enum status: { pending: 0, refused: 5, accepted: 10, finished: 15 }
  
  validates :vehicle, presence: true, if: :status_accepted?
  validates :search_address, :search_city, :search_state, :product_code, :volume, :weight,
            :delivery_address, :delivery_city, :delivery_state, :distance, :price, :deadline,
            :name, :cpf, :status, :carrier_id, :code, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 15 }
  validates :cpf, length: { is: 11 }
  validates :cpf, numericality: true
  validate :vehicle_belongs_carrier

  before_validation :generate_code, on: :create

  private

  def generate_code
      self.code = SecureRandom.alphanumeric(15).upcase
  end

  def status_accepted?
    self.status == 'accepted'
  end

  def vehicle_belongs_carrier
    if self.vehicle != nil && self.carrier != nil && self.vehicle.carrier != self.carrier
      self.errors.add(:vehicle, "Deve pertencer a transportadora que recebeu a Ordem de Serviço.")
    end
  end
end


