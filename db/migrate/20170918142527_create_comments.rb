class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :activity_id
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
