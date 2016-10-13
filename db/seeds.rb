User.create!(email: "not_my_name@ymail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

10.times do |n|
  email = "example-#{n+1}@example.com"
  password = "123456"
  User.create!(
    email: email,
    password: password,
    password_confirmation: password)
end

10.times do |i|
  Device.create name: "iPhone #{i}", content: Faker::Lorem.sentence
end

10.times do |i|
  Device.create name: "Nexus #{i}", content: Faker::Lorem.sentence
end

50.times do
  user = User.offset(rand(User.count)).first
  Review.create user_id: user.id, title: Faker::Lorem.sentence(3),
    content: "", device: Device.first
end
