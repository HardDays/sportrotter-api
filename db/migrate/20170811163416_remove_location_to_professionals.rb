class RemoveLocationToProfessionals < ActiveRecord::Migration[5.1]
  def change
    add_column :professionals, :location, :string
  end
end
