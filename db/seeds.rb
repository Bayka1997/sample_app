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
