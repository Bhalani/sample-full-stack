Food.create(name: "banana", calories: 120)
Food.create(name: "mango", calories: 100)
Food.create(name: "burger", calories: 400)
Food.create(name: "pizza", calories: 600)
Food.create(name: "sandwich", calories: 300)
Food.create(name: "samosa", calories: 180)
Food.create(name: "hot dog", calories: 300)

foods = Food.all
date_range = ((DateTime.now - 14.days)..DateTime.now).to_a
food_entries = (10..40).to_a
5.times do
  first_name, last_name = Faker::Name.name.split(" ")
  user = User.create(first_name: first_name, last_name: last_name, email: Faker::Internet.email, role: :user)

  food_entries.sample.times do
    food = foods.sample
    UserCalory.create(food: food, user: user, calories: food.calories, consume_at: date_range.sample)
  end
end

User.create(first_name: "admin", last_name: "admin", email: "admin@localhost.com", role: "admin")

user = User.first
date_range = ((DateTime.now - 7.days)..(DateTime.now - 2.days)).to_a
foods = Food.all
31.times do
  food = foods.sample
  sleep 1
  UserCalory.create(food: food, user: user, calories: food.calories, consume_at: date_range.sample)
end
