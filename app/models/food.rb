# == Schema Information
#
# Table name: foods
#
#  id         :bigint           not null, primary key
#  name       :string
#  calories   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_foods_on_name  (name)
#
class Food < ApplicationRecord
  validates :name, :calories, presence: true

  has_many :user_calories, class_name: "UserCalory"
end
