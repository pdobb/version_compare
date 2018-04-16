require "simplecov"
SimpleCov.start do
  add_filter "/bin/"
  add_filter "/test/"
end
puts "SimpleCov enabled."

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "version_compare"

require "minitest/autorun"
require "minitest/reporters"
require "pry"

Minitest::Test.make_my_diffs_pretty!
reporter_options = { color: true }
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)

def context(*args, &block)
  describe(*args, &block)
end
