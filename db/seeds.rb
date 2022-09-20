# frozen_string_literal: true

require 'faker'
require 'open-uri'

User.destroy_all

def image_fetcher
  URI.parse(Faker::Avatar.image).open
end

arr = %w[Public Private]

full_name = 'Admin'
email = 'admin@instagram.com'
password = 'admins'
bio = Faker::Lorem.paragraph_by_chars(number: 10)
status = arr[rand(0..1)]
u = User.new(full_name: full_name, email: email, password: password, status: status, bio: bio)
u.avatar.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
u.save!

3.times do
  full_name = Faker::Name.name
  email = Faker::Internet.unique.safe_email
  password = Faker::Internet.password
  bio = Faker::Lorem.paragraph_by_chars(number: 10)
  status = arr[rand(0..1)]
  u = User.new(full_name: full_name, email: email, password: password, status: status, bio: bio)
  u.avatar.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
  u.save!
end

content = Faker::Lorem.paragraph_by_chars(number: 20)
users_all = User.all
users_all.each do |user|
  p = user.posts.new(content: content)
  p.images.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
  p.save!
  s = user.stories.new
  s.image.attach(io: image_fetcher, filename: 'test.png', content_type: 'image/*')
  s.save!
end
