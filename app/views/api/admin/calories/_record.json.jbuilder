json.id record.id
json.consume_at record.consume_at.in_time_zone(@request_timezone).to_s.split(" ").first(2).join(" T")
json.name record.food.name
json.calories record.calories
json.is_cheat_food record.is_cheat_food
json.user_name "#{record.user.first_name} #{record.user.last_name}"
