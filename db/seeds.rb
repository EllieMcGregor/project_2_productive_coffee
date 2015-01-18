# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Shop.delete_all
Facility.delete_all

facilities = []
facilities << Facility.create!(name: "WiFi")
facilities << Facility.create!(name: "Wireless Power")
facilities << Facility.create!(name: "Desks")
facilities << Facility.create!(name: "Couches & Lounge Chairs")
facilities << Facility.create!(name: "Conference Room")
facilities << Facility.create!(name: "Meals")

ellie = User.create!(first_name: "Ellie", last_name: "McGregor", email: "ellie.mcgregor@gmail.com", password: "password", role: :admin)
ellie.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}")

daniel = User.create!(first_name: "Daniel", last_name: "Easterman", email: "daniel.easterman@gmail.com", password: "password", role: :admin)
daniel.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}")

sebastian = User.create!(first_name: "Sebastian", last_name: "Riddle", email: "sebastian.riddle@gmail.com", password: "password", role: :admin)
sebastian.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}")

10.times do
  user = User.create!(first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.last_name}", email: "#{Faker::Internet.email}", password: "password", user_image: "#{Faker::Avatar.image}", role: :normal)
  
  user.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}")
  
  users_shop = user.shops.first

  number_of_facilities = rand(1..facilities.count)
  users_shop.facilities << facilities.sample(number_of_facilities)
end