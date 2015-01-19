class AddAddressFieldsToShop < ActiveRecord::Migration
  def change
    add_column :shops, :street, :string
    add_column :shops, :city, :string
    add_column :shops, :postcode, :string
    add_column :shops, :country, :string
  end
end
