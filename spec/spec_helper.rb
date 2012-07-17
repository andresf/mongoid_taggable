require 'bundler'
Bundler.setup

require 'mongoid'
require 'database_cleaner'

require 'mongoid_taggable'

SPEC_DIR = Pathname.new(__FILE__).dirname
Dir[SPEC_DIR.join('support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  # http://mongoid.org/docs/integration/
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end

Mongoid.configure do |config|
  config.allow_dynamic_fields = true
  config.master = Mongo::Connection.new.db('mongoid_taggable_test')
end
