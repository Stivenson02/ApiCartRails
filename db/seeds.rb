require 'faker'

# Cantidad de productos a crear
product_count = 50

product_count.times do
  Product.create!(
    name: Faker::Commerce.unique.product_name, # Nombres únicos
    price: rand(100..10000) # Precio aleatorio entre 100 y 10,000
  )
end

puts "#{product_count} productos creados exitosamente."