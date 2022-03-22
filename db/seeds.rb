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
user4 = User.create!(
  username: "Andy",
  email: "andy@users.com",
  password: default_password
)
user5 = User.create!(
  username: "Eric",
  email: "eric@users.com",
  password: default_password
)
user6 = User.create!(
  username: "Francine",
  email: "francine@users.com",
  password: default_password
)
user7 = User.create!(
  username: "Georgia",
  email: "georgia@users.com",
  password: default_password
)
user8 = User.create!(
  username: "Jerry",
  email: "jerry@users.com",
  password: default_password
)
users = [user1, user2, user3, user4, user5, user6, user7, user8]

users.map do |user|
  file = File.open("db/support/#{user.username}.jpg")
  user.photo.attach(io: file, filename: "#{user.username}.jpg", content_type: 'image/jpg')
  user.save!
end
puts "---done---"

puts "---creating fake chefs---"
chef1 = Chef.create!(
  address: "Amsterdam 300, Hipódromo, Mexico City, CDMX",
  user: user1
)
chef2 = Chef.create!(
  address: "Tlacotalpan 30, Roma Sur, Mexico City, CDMX",
  user: user2
)
chef3 = Chef.create!(
  address: "Av México 49, Hipódromo, Mexico City, CDMX",
  user: user4
)
chef4 = Chef.create!(
  address: "Tapachula 88, Roma Norte, Mexico City, CDMX",
  user: user5
)
chef5 = Chef.create!(
  address: "Avenida Tamaulipas 30, La Condesa, Mexico City, CDMX",
  user: user6
)
chef6 = Chef.create!(
  address: "Puebla 77, Roma Norte, Mexico City, CDMX",
  user: user7
)
chef7 = Chef.create!(
  address: "Culiacan 26, Hipódromo, Mexico City, CDMX",
  user: user8
)
puts "---done---"
chefs = [chef1, chef2, chef3, chef4, chef5, chef6, chef7]

puts "---creating fake meals---"

meal_names = ["Chicken Butter Curry", "Caesar Salad", "Chicken Ramen", "Green Salad",
              "Guacamole Dip", "Shrimp Pasta with Creamy Tomato Sauce",
              "Fresh Pasta", "Salmon with Tomato Soup", "Chocolate Chip Cookies", "Wonton Soup",
              "Meatball Pasta", "Cinnamon Roll", "Walnut Bread", "Pasta Salad", "Steamed Dumplings",
              "Arugula Mozzarella Pizza", "Chocolate Donuts", "Cauliflower Dip", "Taiyaki Waffle"]

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

meals.first.update(description: "Finger-Lickin’ chicken butter curry (Murgh Makhani) - chicken with a spiced tomato and butter (makhan) sauce.
  This special dish from my grandma's secret recipe makes the butter sauce creamy yet not too heavy.
  It goes well with the tender and juicy chicken thanks to a deliciously spiced yogurt marinade. My neighbours LOVE this dish. It is now your turn to try!")
meals.last.update(description: "Taiyaki is a Japanese fish-shaped waffle, commonly sold as street food. It imitates the shape of tai (red sea bream), which it is named after.
  It is crispy on the outside, fluffy on the inside and filled with sweet red bean paste. It is very rare to find this Japanese waffle in Mexico.
  It often sells out quickly, so take your opportunity and try Taiyaki at home!")
puts "done!"

puts "---done---"

puts "---creating fake past cooking sessions---"
cooking_sessions = []
meals[0..3].each do |meal|
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..6),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.backward(days: 1, period: :morning, format: :long),
    end_at: Faker::Time.backward(days: 1, period: :afternoon, format: :long),
    meal: meal
  )
end

meals[4..6].each do |meal|
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..6),
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
meals[7..13].each do |meal|
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..6),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Time.current + rand(1..2).hours,
    end_at: Time.current + rand(3..5).hours,
    meal: meal
  )
end
puts "---done---"

puts "---creating fake future cooking sessions---"
meals[14..19].each do |meal|
  chef = meal.chef
  cooking_sessions << CookingSession.create!(
    max_portions: rand(2..6),
    address: chef.address,
    longitude: chef.longitude,
    latitude: chef.latitude,
    start_at: Faker::Time.forward(days: 1, period: :morning, format: :long),
    end_at: Faker::Time.forward(days: 1, period: :afternoon, format: :long),
    meal: meal
  )
end

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
