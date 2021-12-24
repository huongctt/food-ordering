class AddInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, default: false
  end
end
