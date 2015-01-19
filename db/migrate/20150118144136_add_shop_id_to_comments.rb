class AddShopIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :shop_id, :integer
  end
end
