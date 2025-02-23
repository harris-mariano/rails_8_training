# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#   Seed Users
puts "Creating Users..."

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Seed Blog Posts with Comments
puts "Creating Blog Posts and Comments..."
users = User.all

50.times do
  article = users.sample.articles.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 3).join("\n\n")
  )

  rand(5..17).times do
    article.comments.create!(
      body: Faker::Lorem.sentence,
      user: users.sample
    )
  end
end

puts "Seeding completed!"
