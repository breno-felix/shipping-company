class OrderService < ApplicationRecord
  belongs_to :carrier
  enum status: { pending: 0, refused: 5, accepted: 10, finished: 15 }

  validates :search_address, :search_city, :search_state, :product_code, :volume, :weight,
            :delivery_address, :delivery_city, :delivery_state, :distance, :price, :deadline,
            :name, :cpf, :status, :carrier_id, :code, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 15 }
  validates :cpf, length: { is: 11 }
  validates :cpf, numericality: true

  before_validation :generate_code, on: :create

  private

  def generate_code
      self.code = SecureRandom.alphanumeric(15).upcase
  end
end


