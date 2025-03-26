class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :current_price
      t.integer :stock_quantity
      t.boolean :organic
      t.boolean :on_sale
      t.date :new_until

      t.timestamps
    end
  end
end
