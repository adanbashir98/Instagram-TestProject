# frozen_string_literal: true

require 'faker'

3.times do
  full_name = Faker::Name.name
  email = Faker::Internet.unique.safe_email
  password = Faker::Internet.password
  avatar = Faker::Avatar.image
  User.create(full_name: full_name, email: email, password: password, avatar: avatar)
end

6.times do
  content = Faker::Lorem.sentence
  p = Post.create(content: content)
  p.images.attach(io: File.open('/home/dev/Downloads/test.png'), filename: 'test.png', content_type: 'image/*')
end

6.times do
  s = Story.create
  s.image.attach(io: File.open('/home/dev/Downloads/test.png'), filename: 'test.png', content_type: 'image/*')
end
