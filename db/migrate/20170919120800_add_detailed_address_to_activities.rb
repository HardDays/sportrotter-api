class AddDetailedAddressToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :detailed_address, :string
  end
end
