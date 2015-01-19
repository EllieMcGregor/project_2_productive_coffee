class Facility < ActiveRecord::Base
  has_many :shops_facility
  has_many :shops, through: :shops_facility

  validates :name, presence: true
end
