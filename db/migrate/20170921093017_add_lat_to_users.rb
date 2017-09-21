class AddLatToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lat, :float
  end
end
