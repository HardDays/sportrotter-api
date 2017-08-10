class CreateProfessionals < ActiveRecord::Migration[5.1]
  def change
    create_table :professionals do |t|
      t.integer :background_id
      t.integer :diploma_id
      t.string :address
      t.string :phone
      t.string :description

      t.timestamps
    end
  end
end
