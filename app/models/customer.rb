class Customer < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :purchase_items, through: :purchases
  has_many :digital_assets, through: :purchase_items

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
