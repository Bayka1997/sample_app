require "ffaker"

User.create!(name:  "Nguyễn Văn Bảy",
  email: "bay@gmail.com",
  password: "111",
  password_confirmation: "111",
  admin: true, 
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
name  = FFaker::Name.name
email = "bay-#{n+1}@gmail.com"
password = "111"
User.create!(name:  name,
  email: email,
  password: password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = FFaker::Lorem.sentence(5)
  users.each {|user| user.microposts.create!(content: content)}
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
