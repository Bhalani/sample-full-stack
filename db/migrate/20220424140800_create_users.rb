# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :first_name,         null: false
      t.string :last_name
      t.string :role,               null: false, default: 'user'
      t.string :token,              null: false
      t.string :email,              null: false, default: ''
      t.integer :daily_calorie_limit, null: false, default: 2100
      # t.string :encrypted_password, null: false, default: ''

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
