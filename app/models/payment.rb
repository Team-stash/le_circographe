class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true
  has_many :users, through: :donations
  has_many :users, through: :user_memberships

  # validates :payment_method, :amount, presence: true
end
