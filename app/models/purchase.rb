class Purchase < ApplicationRecord
  belongs_to :customer
  has_many :purchase_items, dependent: :destroy
  has_many :digital_assets, through: :purchase_items

  validates :customer_id, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending completed cancelled] }
  validate :has_at_least_one_item

  def add_item(digital_asset)
    purchase_items.create!(
      digital_asset: digital_asset,
      price_at_purchase: digital_asset.price
    )
    update_total_amount
  end

  private

  def update_total_amount
    update(total_amount: purchase_items.sum(:price_at_purchase))
  end

  def has_at_least_one_item
    if purchase_items.empty?
      errors.add(:base, "Purchase must have at least one item")
    end
  end
end
