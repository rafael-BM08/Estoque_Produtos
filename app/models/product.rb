class Product < ApplicationRecord
  has_many :stock_movements

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :description, presence: true
end
