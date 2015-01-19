# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

maxLat = 51.514881121099904
minLat = 51.492151803709525
maxLng = -0.09693947143827275
minLng = -0.1293877362387679 

User.delete_all
Shop.delete_all
Facility.delete_all
Comment.delete_all

facilities = []
facilities << Facility.create!(name: "WiFi")
facilities << Facility.create!(name: "Wireless Power")
facilities << Facility.create!(name: "Desks")
facilities << Facility.create!(name: "Couches & Lounge Chairs")
facilities << Facility.create!(name: "Conference Room")
facilities << Facility.create!(name: "Meals")

ellie = User.create!(first_name: "Ellie", last_name: "McGregor", email: "ellie.mcgregor@gmail.com", password: "password", role: :admin)
ellie.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng))

daniel = User.create!(first_name: "Daniel", last_name: "Easterman", email: "daniel.easterman@gmail.com", password: "password", role: :admin)
daniel.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng))

sebastian = User.create!(first_name: "Sebastian", last_name: "Riddle", email: "sebastian.riddle@gmail.com", password: "password", role: :admin)
sebastian.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng))

10.times do
  user = User.create!(first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.last_name}", email: "#{Faker::Internet.email}", password: "password", user_image: "#{Faker::Avatar.image}", role: :normal)
  
  user.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}", latitude: rand(minLat..maxLat), longitude: rand(minLng..maxLng))
  
  users_shop = user.shops.first

  number_of_facilities = rand(1..facilities.count)
  users_shop.facilities << facilities.sample(number_of_facilities)
end

shops = Shop.all
users = User.all

shops.each do |shop|
  number_of_comments = rand(0..10)
  number_of_comments.times do
    shop.comments.create!(title:"#{Faker::Company.bs}", comment: "#{Faker::Lorem.paragraph}", user: users.sample)
  end
end
