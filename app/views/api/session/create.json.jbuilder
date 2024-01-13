if @current_user
  json.user do
    json.id @current_user.id
    json.first_name @current_user.first_name
    json.last_name @current_user.last_name
    json.email @current_user.email
    json.daily_calorie_limit @current_user.daily_calorie_limit
  end
else
  json.error "Invalid token"
end
