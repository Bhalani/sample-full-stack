class User < ApplicationRecord
  paginates_per 10

  validates :first_name, :email, :token, :email, :daily_calorie_limit, presence: true

  before_validation :set_token, on: :create

  has_many :user_calories, class_name: "UserCalory"

  enum role: { user: "user", admin: "admin" }.freeze

  def set_token
    self.token = SecureRandom.hex(16)
  end

  def consumed_calories_today
    user_calories.where(consume_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day, is_cheat_food: false).pluck(:calories).sum
  end
end
