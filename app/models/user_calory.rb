# == Schema Information
#
# Table name: user_calories
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  food_id       :bigint           not null
#  is_cheat_food :boolean
#  consume_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_user_calories_on_food_id  (food_id)
#  index_user_calories_on_user_id  (user_id)
#
class UserCalory < ApplicationRecord
  belongs_to :user
  belongs_to :food

  validates :calories, :consume_at, presence: true
end
