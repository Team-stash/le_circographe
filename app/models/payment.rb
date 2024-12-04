class Payment < ApplicationRecord
  belongs_to :user_membership

  has_many :users, through: :user_memberships

  # validates :payment_method, :amount, presence: true
end
