class CreateCalendarDates < ActiveRecord::Migration[5.1]
  def change
    create_table :calendar_dates do |t|
      t.timestamp :date
      t.integer :activity_id

      t.timestamps
    end
  end
end
