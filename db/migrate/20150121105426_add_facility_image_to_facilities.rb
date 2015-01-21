class AddFacilityImageToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :facility_image, :string
  end
end
