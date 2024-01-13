class CreateUserCalories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_calories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.boolean :is_cheat_food, null: false, default: false
      t.datetime :consume_at
      t.integer :calories

      t.timestamps
    end
  end
end
