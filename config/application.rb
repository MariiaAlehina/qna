require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/spec)
    config.assets.initialize_on_precompile = false
    config.action_cable.disable_request_forgery_protection = false
    config.active_job.queue_adapter = :sidekiq
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_spec: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
