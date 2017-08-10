class AddDateOfBirthToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :date_of_birth, :timestamp
  end
end
