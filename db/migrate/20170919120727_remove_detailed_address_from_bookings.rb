class RemoveDetailedAddressFromBookings < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :detailed_address, :string
  end
end
