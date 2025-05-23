puts "Seeding data..."

PurchaseItem.delete_all
Purchase.delete_all
DigitalAsset.delete_all
Creator.delete_all
Customer.delete_all

creators = 3.times.map do |i|
  Creator.create!(name: "Creator #{i + 1}", email: "creator#{i + 1}@example.com")
end

creators.each do |creator|
  5.times do |i|
    creator.digital_assets.create!(
      title: "Digital Asset #{i + 1} by #{creator.name}",
      description: "Description for digital asset #{i + 1}",
      file_url: "http://example.com/digital_asset#{i + 1}.jpg",
      price: rand(10.0..50.0).round(2)
    )
  end
end

customers = 2.times.map do |i|
  Customer.create!(name: "Customer #{i + 1}", email: "customer#{i + 1}@example.com")
end

customers.each do |customer|
  purchase = customer.purchases.create!
  3.times do
    digital_asset = DigitalAsset.order("RANDOM()").first
    purchase.purchase_items.create!(
      digital_asset: digital_asset,
      price_at_purchase: digital_asset.price
    )
  end
end

# Create default admin user
AdminUser.create!(
  email: 'admin@example.com',
  password: 'password123',
  name: 'Admin User'
) unless AdminUser.exists?(email: 'admin@example.com')

puts "Seeding completed."
