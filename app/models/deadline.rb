class Deadline < ApplicationRecord
  belongs_to :carrier
  validates :initial_kilometer, :final_kilometer, :deadline, presence: true
  validates :initial_kilometer, numericality: { only_integer: true }
  validates :deadline, numericality: { only_integer:true, greater_than: 0 }
  validates :final_kilometer, numericality: { only_integer:true, greater_than: :initial_kilometer }
  
end
