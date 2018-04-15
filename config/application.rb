require_relative 'boot'

require 'rails'

# Include each railties manually, excluding `active_storage/engine`
%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BootstrapConfigurator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.helper false
      g.assets false
      g.helper false
      g.view_specs false
    end

    if ENV['MEMCACHEDCLOUD_SERVERS']
      config.cache_store = :dalli_store,
                           (ENV['MEMCACHEDCLOUD_SERVERS'] || '').split(','),
                           { username: ENV['MEMCACHEDCLOUD_USERNAME'],
                             password: ENV['MEMCACHEDCLOUD_PASSWORD'],
                             failover: true,
                             socket_timeout: 1.5,
                             socket_failure_delay: 0.2,
                             down_retry_delay: 60 }
    end

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    if ENV['ASSET_HOST']
      config.action_controller.asset_host = ENV['ASSET_HOST']
      config.action_mailer.asset_host = ENV['ASSET_HOST']
    end

    #config.active_job.queue_adapter = :sidekiq

    config.redis = { url: ENV['REDIS_URL'], size: 1 } if ENV['REDIS_URL']

    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.{rb,yml}"]

    #config.middleware.use Rack::Attack

    config.action_dispatch.default_headers.merge!({
      'Content-Security-Policy' => ENV.fetch('CONTENT_SECURITY_POLICY') { '' },
      'Referrer-Policy' => 'no-referrer-when-downgrade'
    })

    config.action_controller.default_url_options = {
      protocol: :https
    }
  end
end
