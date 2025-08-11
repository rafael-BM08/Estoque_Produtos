class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :movement_type, inclusion: { in: [ "entrada", "saida" ] }
  validates :quantity, numericality: { greater_than: 0 }
end
