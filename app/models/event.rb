class Event < ApplicationRecord
  belongs_to :user
  has_many :event_attendees, dependent: :destroy
  has_many :users, through: :event_attendees

  validates :title, :date, presence: true
end
