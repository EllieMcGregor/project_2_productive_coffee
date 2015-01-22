# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Ratyrate

maxLat = 51.514881121099904
minLat = 51.492151803709525
maxLng = -0.09693947143827275
minLng = -0.1293877362387679

street = "68 Hanbury Street"
postcode = "E1 5JL"
city = "London"
country = "United Kingdom" 

puts "Deleting all existing data"

User.delete_all
Shop.delete_all
Facility.delete_all
ShopsFacility.delete_all
Comment.delete_all
Rate.delete_all
OverallAverage.delete_all
RatingCache.delete_all
AverageCache.delete_all

puts "Creating facilities"

facilities = []
facilities << Facility.create!(name: "WiFi")
facilities << Facility.create!(name: "Wireless Power")
facilities << Facility.create!(name: "Desks")
facilities << Facility.create!(name: "Couches & Lounge Chairs")
facilities << Facility.create!(name: "Conference Room")
facilities << Facility.create!(name: "Meals")

puts "Creating admin users & shops"

ellie = User.create!(first_name: "Ellie", last_name: "McGregor", email: "ellie.mcgregor@gmail.com", password: "password", role: :admin)
ellie.shops.create!(name:"#{Faker::Company.name}", description: "#{Faker::Lorem.paragraph}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng), street: street, city: city, postcode: postcode, country: country)

daniel = User.create!(first_name: "Daniel", last_name: "Easterman", email: "daniel.easterman@gmail.com", password: "password", role: :admin)
daniel.shops.create!(name:"#{Faker::Company.name}", description: "#{Faker::Lorem.paragraph}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng), street: street, city: city, postcode: postcode, country: country)

sebastian = User.create!(first_name: "Sebastian", last_name: "Riddle", email: "sebastian.riddle@gmail.com", password: "password", role: :admin)
sebastian.shops.create!(name:"#{Faker::Company.name}", description: "#{Faker::Lorem.paragraph}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng), street: street, city: city, postcode: postcode, country: country)

puts "Creating normal users & shops"

50.times do
  user = User.create!(first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.last_name}", email: "#{Faker::Internet.email}", password: "password", user_image: "#{Faker::Avatar.image}", role: :normal)
  
  user.shops.create!(name:"#{Faker::Company.name}", description: "#{Faker::Lorem.paragraph}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng), street: street, city: city, postcode: postcode, country: country)
end

shops = Shop.all
users = User.all

shops.each do |shop|
  number_of_comments = rand(0..10)
  
  puts "Creating #{number_of_comments} comments for #{shop.name}"

  number_of_comments.times do
    shop.comments.create!(title:"#{Faker::Company.bs}", comment: "#{Faker::Lorem.paragraph}", user: users.sample)
  end

  number_of_facilities = rand(1..facilities.count)
  
  puts "Adding #{number_of_facilities} random facilities to #{shop.name}"

  shop.facilities << facilities.sample(number_of_facilities)

  number_of_ratings = rand(0..10)
  puts "Adding #{number_of_ratings} ratings to #{shop.name}"
  number_of_ratings.times do
    stars = rand(1..5)
    user = users.sample
    dimension = "overall"
    shop.rate(stars, user, dimension)
  end
end
