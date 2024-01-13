class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :calories

      t.timestamps
    end

    add_index :foods, :name
  end
end
