class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :plans
  has_many :hubs
  has_many :merchant
  has_many :consignments

  # Set user gender
  enum gender: { male: 1, female: 2, others: 3 }

  # Set user status
  enum status: { active: 1, block: 0 }

  # validation
  validates :email, presence: true, uniqueness: true
end


