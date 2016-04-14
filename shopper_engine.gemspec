$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopper_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopper_engine"
  s.version     = ShopperEngine::VERSION
  s.authors     = ["Roman"]
  s.email       = ["w2@live.ru"]
  s.homepage    = "http://github.com/RoM4iK"
  s.summary     = "Shopping cart engine"
  s.description = "Shopping cart engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "haml-rails", "~> 0.9"
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'wicked'


  s.add_development_dependency "sqlite3"
  s.add_development_dependency "devise"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
  s.add_development_dependency "codeclimate-test-reporter"
end
