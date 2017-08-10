class AddUserIdToProffessional < ActiveRecord::Migration[5.1]
  def change
    add_column :professionals, :user_id, :integer
  end
end
