require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
# require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sample
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja

    config.middleware.use Rack::Cors do
      allow do
        # origins 'localhost:3000' , 'localhost:8080'
        origins '*'
        resource '*', headers: :any, methods: %i(get post put patch delete options)
      end
    end

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.assets false

      g.test_framework :rspec, view_specs: false, helper_specs: false, routing_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
