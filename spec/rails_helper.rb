# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'
require 'devise'
require 'database_cleaner'
require 'factory_girl_rails'

# FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
# FactoryGirl.find_definitions

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Shoulda::Matchers
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.before :suite do
    Warden.test_mode!
  end

  config.after :each, type: :feature do
    Warden.test_reset!
  end

  config.filter_rails_from_backtrace!
  config.include Warden::Test::Helpers, :type => :feature
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :view

end
