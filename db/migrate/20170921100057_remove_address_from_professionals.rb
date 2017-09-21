class RemoveAddressFromProfessionals < ActiveRecord::Migration[5.1]
  def change
    remove_column :professionals, :address, :string
  end
end
