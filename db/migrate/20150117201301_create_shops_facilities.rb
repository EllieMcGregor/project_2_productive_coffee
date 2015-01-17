class CreateShopsFacilities < ActiveRecord::Migration
  def change
    create_table :shops_facilities do |t|
      t.references :facility, index: true
      t.references :shop, index: true

      t.timestamps
    end
  end
end
