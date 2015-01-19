class Shop < ActiveRecord::Base
  
  acts_as_commentable

  belongs_to :user
  has_many :shops_facility, dependent: :destroy
  has_many :facilities, through: :shops_facility

  validates :name, presence: true
  validates :email, presence: true
  validates :user, presence: true
end
