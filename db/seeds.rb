puts "---creating fake users---"
default_password = "123456"
user1 = User.create!(
  email: "user1@users.com",
  password: default_password
)
user2 = User.create!(
  email: "user2@users.com",
  password: default_password
)
user3 = User.create!(
  email: "user3@users.com",
  password: default_password
)
puts "---done---"
users = [user1, user2, user3]

puts "---creating fake chefs---"
chef1 = Chef.create!(
  address: "Amsterdam 300a, Hipódromo, Cuauhtémoc, 06100 Ciudad de México, CDMX",
  user: user1
)
chef2 = Chef.create!(
  address: "Guanajuato 165, Roma Nte., Cuauhtémoc, 06700 Ciudad de México, CDMX",
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
puts "---creating fake cooking_sessions---"
10.times do
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..10),
    start_at: Faker::Time.forward(days: 2, period: :morning, format: :long),
    end_at: Faker::Time.forward(days: 2, period: :afternoon, format: :long),
    meal: meals.sample
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
