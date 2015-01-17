class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :shops_facility
  has_many :facilities, through: :shops_facility
end
