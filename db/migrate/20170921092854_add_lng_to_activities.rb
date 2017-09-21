class AddLngToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :lng, :float
  end
end
