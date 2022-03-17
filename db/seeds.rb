puts "---creating fake users---"
default_password = "123456"
user1 = User.create!(
  username: "David",
  email: "david@users.com",
  password: default_password
)
user2 = User.create!(
  username: "Brianna",
  email: "brianna@users.com",
  password: default_password
)
user3 = User.create!(
  username: "Chizu",
  email: "chizu@users.com",
  password: default_password
)
users = [user1, user2, user3]

users.map do |user|
  file = File.open(("db/support/#{user_username.parameterize}.jpg"))
  user.photo.attach(io: file, filename: "#{user_username.parameterize}.jpg", content_type: 'image/jpg')
  user.save!
end
puts "---done---"

puts "---creating fake chefs---"
chef1 = Chef.create!(
  address: "Amsterdam 300a, CDMX",
  user: user1
)
chef2 = Chef.create!(
  address: "Guanajuato 165, CDMX",
  user: user2
)
puts "---done---"
chefs = [chef1, chef2]

meals = []
puts "---creating fake meals---"
10.times do
  meals << Meal.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    chef: chefs.sample
  )
end
puts "---done---"

cooking_sessions = []
puts "---creating fake past cooking sessions---"
3.times do
  meal = meals.sample
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.backward(days: 1, period: :morning, format: :long),
    end_at: Faker::Time.backward(days: 1, period: :afternoon, format: :long),
    meal: meal
  )
end
3.times do
  meal = meals.sample
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.backward(days: 1, period: :afternoon, format: :long),
    end_at: Faker::Time.backward(days: 1, period: :evening, format: :long),
    meal: meal
  )
end
puts "---done---"

puts "---creating fake near future cooking sessions---"
10.times do
  meal = meals.sample
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Time.current + rand(2..3).hours,
    end_at: Time.current + rand(4..5).hours,
    meal: meal
  )
end
puts "---done---"

puts "---creating fake future cooking sessions---"
3.times do
  meal = meals.sample
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.forward(days: 1, period: :morning, format: :long),
    end_at: Faker::Time.forward(days: 1, period: :afternoon, format: :long),
    meal: meal
  )
end
3.times do
  meal = meals.sample
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.forward(days: 1, period: :afternoon, format: :long),
    end_at: Faker::Time.forward(days: 1, period: :evening, format: :long),
    meal: meal
  )
end
puts "---done---"

puts "---creating fake reservations---"
5.times do
  Reservation.create!(
    portion_count: rand(2..10),
    user: users.sample,
    cooking_session: cooking_sessions.sample
  )
end
puts "---done---"
