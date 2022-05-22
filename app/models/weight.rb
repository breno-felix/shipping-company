class Weight < ApplicationRecord
  belongs_to :carrier

  validates :initial_weight, :final_weight, :price_km, presence: true
  validates :initial_weight, numericality: { only_integer: true }
  validates :price_km, numericality: { only_integer:true, greater_than_or_equal_to: 0 }
  validates :final_weight, numericality: { only_integer:true, greater_than: :initial_weight }
end
