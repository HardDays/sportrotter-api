class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.string :body
      t.integer :from_id
      t.integer :to_id
      t.boolean :is_read

      t.timestamps
    end
  end
end
