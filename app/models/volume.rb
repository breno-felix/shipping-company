class Volume < ApplicationRecord
  belongs_to :carrier
  validates :initial_volume, :final_volume, :price_km, presence: true
  validates :initial_volume, numericality: { only_integer: true }
  validates :price_km, numericality: { only_integer:true, greater_than_or_equal_to: 0 }
  validates :final_volume, numericality: { only_integer:true, greater_than: :initial_volume }
  
end
