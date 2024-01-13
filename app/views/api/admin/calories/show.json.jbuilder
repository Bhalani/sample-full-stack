json.food_entry do
  json.partial! partial: 'record', locals: { record: @user_calory }
end
