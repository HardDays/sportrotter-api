class AddGenderIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender_id, :integer
  end
end
