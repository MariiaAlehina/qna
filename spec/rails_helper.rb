# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'factory_bot_rails'
require 'spec_helper'
require 'capybara/rspec'
require 'shoulda/matchers'
require 'smart_rspec'
require 'cancan/matchers'
require 'pundit/rspec'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?


 Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
 Dir[Rails.root.join('spec/accept/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.extend ControllerMacross, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend AcceptenceMacross, type: :feature

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end