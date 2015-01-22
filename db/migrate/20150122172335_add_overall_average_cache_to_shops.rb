class AddOverallAverageCacheToShops < ActiveRecord::Migration
  def change
    add_column :shops, :overall_average_cache, :float, default: 0

    Shop.all.each do |shop|
      shop.save
    end
  end
end
