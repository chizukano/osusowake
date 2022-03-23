puts "---creating fake users---"
default_password = "123456"

user_names = ["David", "Brianna", "Chizu", "Andy", "Eric", "Francine", "Georgia", "Jerry"]

users = []
user_names.each do |user|
  users << User.create!(
    username: user,
    email: "#{user.downcase}@users.com",
    password: default_password
  )
end

users.map do |user|
  file = File.open("db/support/#{user.username}.jpg")
  user.photo.attach(io: file, filename: "#{user.username}.jpg", content_type: 'image/jpg')
  user.save!
end
puts "---done---"

puts "---creating fake chefs---"
chefs = []
chefs_address = ["Amsterdam 300, Hipódromo, Mexico City, CDMX", "Tlacotalpan 30, Roma Sur, Mexico City, CDMX", "Av México 49, Hipódromo, Mexico City, CDMX",
                  "Tapachula 88, Roma Norte, Mexico City, CDMX", "Avenida Tamaulipas 30, La Condesa, Mexico City, CDMX",
                  "Puebla 77 Roma Norte, Mexico City, CDMX", "Culiacan 26, Hipódromo, Mexico City, CDMX"
                ]
chefs_address_index = 0
chefs_bio = ["I have been cooking since I was little. Cooking and sharing is my passion!",
              "I have travelled all over the world, and my motto is to cook outside the box!",
              "I just graduated from culinary school in Mexico City, and my dream is to own a restaurant!",
              "I always share my food with neighbours and friends nearby. It is now your turn to try!"
            ]

users[0..5].each do |user|
  chefs << Chef.create!(
    address: chefs_address[(chefs_address_index += 1)],
    user: user,
    bio: chefs_bio.sample
  )
end
puts "---done---"

puts "---creating fake meals---"

meal_names = ["Chicken Butter Curry", "Caesar Salad", "Chicken Ramen", "Green Salad",
              "Guacamole Dip", "Shrimp Pasta with Creamy Tomato Sauce",
              "Fresh Pasta", "Salmon with Tomato Soup", "Chocolate Chip Cookies", "Wonton Soup",
              "Meatball Pasta", "Cinnamon Roll", "Walnut Bread", "Pasta Salad", "Steamed Dumplings",
              "Arugula Mozzarella Pizza", "Chocolate Donuts", "Cauliflower Dip", "Taiyaki Waffle"]

meals = []
current_chef_index = 0
meal_names.map do |meal_name|
  file2 = File.open("db/support/#{meal_name.parameterize}.jpg")
  meal = Meal.new(
    name: meal_name,
    description: Faker::Food.description,
    chef: chefs[(current_chef_index += 1) % chefs.size]
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
