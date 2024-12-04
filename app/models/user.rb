class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :sessions, dependent: :destroy

  enum :role, %i[guest membership circus_membership volunteer admin godmode], default: :guest

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password
  validates :email_address, presence: true, uniqueness: true

end
