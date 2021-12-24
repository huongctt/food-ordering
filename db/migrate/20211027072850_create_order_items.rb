class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 0
      t.integer :unitprice, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
