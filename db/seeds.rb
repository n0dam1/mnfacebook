# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
100.times do |n|
  email = Faker::Internet.email
  password = "password"
  User.create!
  (
  email: email,
  password: password,
  password_confirmation: password,
  )
end
# Topics
n = 1
while n <= 100
  Topic.create(
    title: "あああ",
    content: "hoge",
    user_id: n
  )
  n = n + 1
end
# Comments
# Messages
# Conversations
# Relationships
