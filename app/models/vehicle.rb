class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :brand, :model, :plate, :year, :capacity, presence: true
  validates :year, numericality: { only_integer:true, greater_than: 1990 }
  validates :capacity, numericality: { only_integer:true, greater_than: 0 }

  def full_description
    "#{brand} #{model} - #{plate}"
  end
end
