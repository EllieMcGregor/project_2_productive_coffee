class Shop < ActiveRecord::Base

  after_save :update_overall_average_cache

  default_scope { order('shops.overall_average_cache desc') }

  mount_uploader :shop_image, ShopImageUploader
  acts_as_commentable
  ratyrate_rateable "overall"

  belongs_to :user
  has_many :shops_facility, dependent: :destroy
  has_many :facilities, through: :shops_facility

  validates :name, presence: true
  validates :email, presence: true
  validates :user, presence: true

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  
  def address
    [street, city, postcode, country].compact.join(', ')
  end

  def rating
    overall_average.try(:avg).to_f
  end

  private
  def update_overall_average_cache
    update_column :overall_average_cache, rating
  end
end
