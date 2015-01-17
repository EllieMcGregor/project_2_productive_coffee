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

50.times do
  user = User.create!(first_name: "#{Faker::Name.first_name}", last_name: "#{Faker::Name.last_name}", email: "#{Faker::Internet.email}", password: "password", user_image: "#{Faker::Avatar.image}")
  user.shops.create!(name:"#{Faker::Company.name}", email: "#{Faker::Internet.email}", phone: "#{Faker::PhoneNumber.phone_number}")
end

Facility.create!(name: "WiFi")
Facility.create!(name: "Wireless Power")
Facility.create!(name: "Desks")
Facility.create!(name: "Couches & Lounge Chairs")
Facility.create!(name: "Conference Room")
Facility.create!(name: "Meals")