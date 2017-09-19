class AddDetailedAddressToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :detailed_address, :string
  end
end
