class User < ApplicationRecord

  after_initialize :assign_default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook]

  enum role: [
   :blocked,
   :active,
   :moderator,
   :admin,
   :superadmin
  ]

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    # user.uid = auth.uid
    user.password = Devise.friendly_token[0,20]
    user.password_confirmation = user.password
    user.username = "#{auth.info.name.split(" ").first.capitalize}#{auth.uid.first(4)}"   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
   end
  end

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, presence: true, length: { maximum: 50, minimum: 4 },
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_-]*(?:[a-zA-Z0-9])\z/ }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  private
  
    def assign_default_role
      self.role ||= :active
    end

end
