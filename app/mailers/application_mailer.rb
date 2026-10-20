# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # Sender address per environment: config.action_mailer.default_options (production/staging.rb),
  # never from a local .env file (dev machines carry a personal Gmail there for SMTP testing).
  default from: "no-reply@lecircographe.fr"
  layout "mailer"

  private

  # Set unsubscribe URL for newsletter emails
  def set_unsubscribe_url
    return if @user&.email.blank?

    subscriber = NewsletterSubscriber.find_by(email: @user.email)
    @unsubscribe_url = newsletter_unsubscribe_url(subscriber.unsubscribe_token) if subscriber&.unsubscribe_token
  end
end
