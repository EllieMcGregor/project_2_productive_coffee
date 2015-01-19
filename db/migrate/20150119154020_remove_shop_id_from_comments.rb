class RemoveShopIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :shop_id, :integer
  end
end
