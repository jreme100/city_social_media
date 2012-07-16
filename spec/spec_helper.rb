require 'rubygems'
require 'spork'

ENV['RAILS_ENV'] ||= 'test'

Spork.prefork do
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

  RSpec.configure do |config|
    DatabaseCleaner.strategy = :deletion
    config.extend SubdomainHelpers
    config.fixture_path = %Q(#{::Rails.root}/spec/fixtures)
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.after do
      DatabaseCleaner.clean
      ActionMailer::Base.deliveries.clear
    end
  end
end

Spork.each_run do

end