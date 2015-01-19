class ShopsFacility < ActiveRecord::Base
  belongs_to :facility
  belongs_to :shop

  validates :facility, presence: true
  validates :shop, presence: true
end
