require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IssuesTracker
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    I18n.enforce_available_locales = false

    config.time_zone = 'Moscow'

    config.local_zone = 'Moscow'

    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ru

    I18n.enforce_available_locales = false

    config.after_initialize do |app|
      app.routes.append{ get '*a', :to => 'application#render_404' } unless config.consider_all_requests_local
    end

    config.github_client = Octokit::Client.new(:access_token => Rails.application.secrets.github_access_token)
  end
end
