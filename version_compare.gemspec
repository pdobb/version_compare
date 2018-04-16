lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version_compare/version"

Gem::Specification.new do |spec|
  spec.name          = "version_compare"
  spec.version       = VersionCompare::VERSION
  spec.authors       = ["Paul Dobbins"]
  spec.email         = ["paul.dobbins@icloud.com"]

  spec.summary       = %q{VersionCompare simplifies comparison of version numbers with other version numbers.}
  spec.description   = %q{VersionCompare simplifies comparison of version numbers with other version numbers. It aims to be as light and flexible as possible. Inputs can be a String, Integer, Float, Array, or any object that defines `#to_comparable_version`.}
  spec.homepage      = "https://github.com/pdobb/version_compare"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.2"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "pry-byebug", "~> 3.6"
end
