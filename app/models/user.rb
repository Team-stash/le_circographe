class User < ApplicationRecord
  enum :role, %i[guest membership circus_membership volunteer admin godmode], default: :guest
  
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
