json.exceeded_records @exceeded_calories_per_day.each do |record|
  json.user_id record.user_id
  json.total_calories record.total_calories
  json.consume_date record.consume_date
  json.user_name "#{@users[record.user_id].first.first_name} #{@users[record.user_id].first.last_name}"
  json.limit @users[record.user_id].first.daily_calorie_limit
end

json.partial! partial: '/api/shared/pagination', locals: {
  kind: @exceeded_calories_per_day
}
