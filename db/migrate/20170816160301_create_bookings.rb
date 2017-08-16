class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :activity_id
      t.timestamp :date
      t.integer :num_of_participants
      t.boolean :is_validated

      t.timestamps
    end
  end
end
