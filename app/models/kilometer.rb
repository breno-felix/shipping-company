class Kilometer < ApplicationRecord
  belongs_to :carrier
  validates :initial_kilometer, :final_kilometer, :price_km, presence: true
  validates :initial_kilometer, numericality: { only_integer: true }
  validates :price_km, numericality: { only_integer:true, greater_than_or_equal_to: 0 }
  validates :final_kilometer, numericality: { only_integer:true, greater_than: :initial_kilometer }
  
end
