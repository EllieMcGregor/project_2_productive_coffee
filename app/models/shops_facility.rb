class ShopsFacility < ActiveRecord::Base
  belongs_to :facility
  belongs_to :shop
end
