class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :subtotal
      t.decimal :gst_amount
      t.decimal :pst_amount
      t.decimal :hst_amount
      t.decimal :total
      t.string :stripe_payment_id
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_postal_code
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
