# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/rails"

include ::Conversions

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }
