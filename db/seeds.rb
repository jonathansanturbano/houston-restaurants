require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Restaurant.destroy_all && User.destroy_all

CATEGORIES = ["Thai", "Mexican", "American", "Vietnamese", "Peruvian"]

5.times do |user|
  User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
end

users = User.all



10.times do |restaurant|
  restaurant = Restaurant.create!(name: Faker::Restaurant.name, description: Faker::Restaurant.description, category: CATEGORIES.sample, user: users.sample)
  file = URI.open("https://source.unsplash.com/random/800x600")
  restaurant.image.attach(io: file, filename: restaurant.name)
end

restaurant = Restaurant.create!(name: "Bananas Thai", description: "family-friendly restaurant with delicious Thai food", category: "Thai", user: User.last)
file = URI.open("https://source.unsplash.com/random/800x600")
restaurant.image.attach(io: file, filename: restaurant.name)

restaurant = Restaurant.create!(name: "Five Guys", description: "family-friendly restaurant with delicious Burgers and Fries", category: "Thai", user: User.last)
restaurant = Restaurant.create!(name: "Tierra del Fuego", description: "Best tacos for sure in Houston", category: "Thai", user: User.last)
