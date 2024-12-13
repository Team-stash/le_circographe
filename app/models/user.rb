class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :sessions, dependent: :destroy
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :event_attendees, dependent: :destroy
  has_many :events, through: :event_attendees
  has_many :user_memberships
  has_many :subscription_types, through: :user_memberships
  has_many :training_attendees, through: :user_memberships
  has_many :payments, through: :user_memberships
  has_many :payments, through: :donations

  enum :role, %i[guest membership circus_membership volunteer admin godmode], default: :guest

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }


  alias_attribute :email, :email_address

    # after_create :welcome_send
  # def welcome_send
  #   UserMailer.welcome_email(self).deliver_now
  # end
  
  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.current
    save!
  end

  def password_reset_token_valid?
    password_reset_sent_at.present? && password_reset_sent_at > 2.hours.ago
  end

  def reset_password!(password, password_confirmation)
    self.password_reset_token = nil
    self.password_reset_sent_at = nil
    self.password = password
    self.password_confirmation = password_confirmation
    save!
  end

    def clear_password_reset_token!
      self.password_reset_token = nil
      self.password_reset_sent_at = nil
      save!
    end

  
  scope :published, -> { where(published: true) }

  def has_privileges?
    %w[admin godmode volunteer].include?(self.role)
  end

  def is_interested_in?(event_id)
    events = self.event_attendees
    events.each do |event|
      if event.event_id == event_id
        return true
      end
    end
    false
  end
end
