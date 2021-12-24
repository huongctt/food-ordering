class CreateOrderAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :order_addresses do |t|
      t.string :address
      t.boolean :is_using, default: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
