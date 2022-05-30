class UpdateOrderService < ApplicationRecord
  belongs_to :vehicle
  belongs_to :order_service
  belongs_to :carrier
end
