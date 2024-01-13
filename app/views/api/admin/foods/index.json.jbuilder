json.foods @foods.each do |food|
  json.id food.id
  json.name food.name
  json.calories food.calories
end
