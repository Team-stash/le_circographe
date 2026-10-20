# frozen_string_literal: true

require "rails_helper"

# Le mailer de production est branché (Mailjet, compte Circographe) mais éteint tant que le parcours
# email n'est pas validé en staging : ces specs verrouillent ce choix et la séparation des clés.
RSpec.describe "Mailer delivery configuration by environment" do
  def env_file(name) = Rails.root.join("config/environments/#{name}.rb").read

  describe "production" do
    it "sends nothing unless MAILER_DELIVERIES_ENABLED is explicitly \"true\"" do
      expect(env_file("production")).to include(
        'config.action_mailer.perform_deliveries = ENV.fetch("MAILER_DELIVERIES_ENABLED", "false") == "true"'
      )
    end

    it "ships with deliveries switched off in the Kamal config" do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with("PRODUCTION_SERVER_IP").and_return("127.0.0.1")
      deploy = YAML.safe_load(ERB.new(Rails.root.join("config/deploy.production.yml").read).result, aliases: true)

      expect(deploy.dig("env", "clear", "MAILER_DELIVERIES_ENABLED")).to be(false)
    end

    it "uses the production Mailjet keys, never the sandbox ones" do
      source = env_file("production")

      expect(source).to include("credentials.dig(:mailjet, :production, :api_key)")
      expect(source).not_to include(":sandbox")
    end

    it "sends from a fixed, validated address — not from local .env" do
      source = env_file("production")

      expect(source).to include('config.action_mailer.default_options = { from: "Le Circographe <no-reply@lecircographe.fr>" }')
    end
  end

  describe "development" do
    it "never sends: mails are shown in Letter Opener Web" do
      expect(env_file("development")).to include("config.action_mailer.delivery_method = :letter_opener_web")
      expect(env_file("development")).not_to include("smtp_settings")
    end
  end

  describe "staging" do
    it "uses the sandbox Mailjet keys, never the production ones" do
      source = env_file("staging")

      expect(source).to include("credentials.dig(:mailjet, :sandbox, :api_key)")
      expect(source).not_to include(":production")
    end

    it "sends from MAILER_FROM (validated on the sandbox account), set via Kamal — not local .env" do
      source = env_file("staging")

      expect(source).to include('config.action_mailer.default_options = { from: ENV.fetch("MAILER_FROM", "no-reply@lecircographe.fr") }')

      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with("STAGING_SERVER_IP").and_return("127.0.0.1")
      deploy = YAML.safe_load(ERB.new(Rails.root.join("config/deploy.staging.yml").read).result, aliases: true)
      expect(deploy.dig("env", "clear")).to have_key("MAILER_FROM")
    end
  end
end
