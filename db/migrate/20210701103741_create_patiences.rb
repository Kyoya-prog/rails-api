class CreatePatiences < ActiveRecord::Migration[6.1]
  def change
    create_table :patiences do |t|
      t.integer :money
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.string :category_title,null:false
      t.date :registered_at,null:false
      t.timestamps
    end
    add_index :patiences,[:user_id,:registered_at]
  end
end