class CreateReview < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.string :comment
      t.references :user, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
