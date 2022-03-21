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
  file = File.open("db/support/#{user.username}.jpg")
  user.photo.attach(io: file, filename: "#{user.username}.jpg", content_type: 'image/jpg')
  user.save!
end
puts "---done---"

puts "---creating fake chefs---"
chef1 = Chef.create!(
  address: "Amsterdam 300a, CDMX",
  user: user1
)
chef2 = Chef.create!(
  address: "Tlacotalpan 30, CDMX",
  user: user2
)
puts "---done---"
chefs = [chef1, chef2]

puts "---creating fake meals---"

meal_names = ["Chicken Butter Curry", "Caesar Salad", "Chicken Ramen", "Green Salad",
              "Guacamole Dip", "Shrimp Pasta with Creamy Tomato Sauce",
              "Fresh Pasta", "Salmon with Tomato Soup", "Chocolate Chip Cookies",
              "Meatball Pasta", "Wonton Soup", "Cinnamon Roll", "Walnut Bread", "Pasta Salad",
              "Arugula Mozzarella Pizza", "Chocolate Donuts", "Cauliflower Dip"]

meals = []
meal_names.map do |meal_name|
  file2 = File.open("db/support/#{meal_name.parameterize}.jpg")
  meal = Meal.new(
    name: meal_name,
    description: Faker::Food.description,
    chef: chefs.sample
  )
  meal.photo.attach(io: file2, filename: "#{meal_name.parameterize}.jpg", content_type: 'image/jpg')
  meal.save!
  meals << meal
end
puts "---done---"

puts "---creating fake past cooking sessions---"
cooking_sessions = []
meals[0..2].each do |meal|
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

meals[3..5].each do |meal|
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
meals[6..13].each do |meal|
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
meals[14..16].each do |meal|
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
# 3.times do
#   meal = meals.sample
#   chef = meal.chef
#   cooking_sessions << CookingSession.create!(
#     max_portions: rand(6..10),
#     address: chef.address,
#     longitude: chef.longitude,
#     latitude: chef.latitude,
#     start_at: Faker::Time.forward(days: 1, period: :afternoon, format: :long),
#     end_at: Faker::Time.forward(days: 1, period: :evening, format: :long),
#     meal: meal
#   )
# end
puts "---done---"

puts "---creating fake reservations---"
5.times do
  Reservation.create!(
    portion_count: rand(1..2),
    user: users.sample,
    cooking_session: cooking_sessions.sample
  )
end
puts "---done---"
