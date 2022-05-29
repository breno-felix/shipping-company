class Carrier < ApplicationRecord
  has_many :prices
  enum status: { enabled: 0, disabled: 5 }
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state,
            :email_domain, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }
  validates :registration_number, numericality: true
end
