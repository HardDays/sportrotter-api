class AddLngToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lng, :float
  end
end
