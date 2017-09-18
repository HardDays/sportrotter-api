class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :user_id
      t.integer :activity_id
      t.integer :rate

      t.timestamps
    end
  end
end
