class User < ActiveRecord::Base

  ratyrate_rater

  has_many :shops
  has_many :comments, through: :shops

  validates :first_name, presence: true
  validates :last_name, presence: true
    
  validates :password, length: { in: 8..20 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

    def role?(role_to_compare)
      self.role.to_s == role_to_compare.to_s
    end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.user_image = get_image_path_without_params(auth.info.image)
      user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  private
  def self.get_image_path_without_params(url)
    url.split("?").first
  end
end
