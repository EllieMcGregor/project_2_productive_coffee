class Facility < ActiveRecord::Base
  mount_uploader :facility_image, FacilityImageUploader
  has_many :shops_facility
  has_many :shops, through: :shops_facility

  validates :name, presence: true
end
