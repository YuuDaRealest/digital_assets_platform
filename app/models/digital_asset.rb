class DigitalAsset < ApplicationRecord
  belongs_to :creator
  has_many :purchase_items
  has_many :purchases, through: :purchase_items
  has_many :customers, through: :purchases

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :file_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :price, presence: true, 
                   numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999999.99 }
  validates :creator_id, presence: true

  def purchased_by?(customer)
    customers.include?(customer)
  end
end
