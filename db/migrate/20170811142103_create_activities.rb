class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :image_id
      t.string :title
      t.float :price
      t.integer :num_of_bookings
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
