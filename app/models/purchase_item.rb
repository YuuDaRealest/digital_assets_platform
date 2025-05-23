class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :digital_asset

  validates :price_at_purchase, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :purchase_id, presence: true
  validates :digital_asset_id, presence: true
  validate :digital_asset_not_already_purchased

  private

  def digital_asset_not_already_purchased
    if purchase.customer.purchased_assets.include?(digital_asset)
      errors.add(:base, "You have already purchased this asset")
    end
  end
end
