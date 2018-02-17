class User < ApplicationRecord
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :creator, foreign_key: :creator_id, class_name: 'User'
  has_and_belongs_to_many :roles
  has_one :user_profile
  has_many :plans
  has_many :hubs
  has_many :merchant
  has_many :consignments

  # Set user gender
  enum gender: { male: 1, female: 2, others: 3 }

  # Set user status
  enum status: { active: 1, block: 0 }

  # validation
  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :email, uniqueness: true

  # prevent from login if user is inactive
  def active_for_authentication?
    super && self.active? # i.e. super && self.active
  end

  def inactive_message
    'Sorry, this account has been deactivated.'
  end

  # generating array of symbols of currently logged in user
  def role_symbols
    (roles || []).map { |r| r.title.to_sym }
  end

  # checking the user has the role or not
  def has_role?(role)
    role_symbols.include? role
  end

end


