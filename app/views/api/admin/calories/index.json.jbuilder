json.food_entries @user_calories.each do |record|
  json.partial! partial: 'record', locals: { record: record }
end
json.daily_calorie_limit @current_user.daily_calorie_limit
json.consumed_calorie_today @current_user.consumed_calories_today

json.partial! partial: '/api/shared/pagination', locals: {
  kind: @user_calories
}
