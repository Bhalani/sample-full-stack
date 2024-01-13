json.users @users.each do |user|
  json.id user.id
  json.first_name user.first_name
  json.last_name user.last_name
  json.email user.email
  json.daily_calorie_limit user.daily_calorie_limit
end
