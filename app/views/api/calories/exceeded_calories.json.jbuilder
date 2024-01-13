json.exceeded_records @exceeded_calories_per_day.each do |record|
  json.total_calories record.total_calories
  json.consume_date record.consume_date
end

json.daily_calorie_limit @current_user.daily_calorie_limit

json.partial! partial: '/api/shared/pagination', locals: {
  kind: @exceeded_calories_per_day
}
