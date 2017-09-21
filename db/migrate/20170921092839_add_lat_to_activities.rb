class AddLatToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :lat, :float
  end
end
