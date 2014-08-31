$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "version_compare"
  s.version     = "0.0.1"
  s.authors     = ["Paul Dobbins"]
  s.email       = ["pdobbins@gmail.com"]
  s.homepage    = "https://github.com/pdobb/version_compare"
  s.summary     = "Compare versions"
  s.description = "Version Compare allows you to easily compare if one Version is >, >=, ==, !=, <, or <= to another Version."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", ">= 3.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
end
