$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bizarroids/slider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bizarroids_slider"
  s.version     = Bizarroids::Slider::VERSION
  s.authors     = ["Corlinus"]
  s.email       = ["corlinus@gmail.com"]
  s.homepage    = "https://github.com/corlinus/bizarroids_slider"
  s.summary     = "Bizarroids Slider provides user managable collections of images."
  s.description = "Bizarroids Slider provides user managable collections of images."
  s.require_path = "lib"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.2"
  s.add_dependency "simple_form", "~> 3.0.0"
  s.add_dependency "cancancan", "~> 1.9.0"
  s.add_dependency "acts_as_list", "~> 0.6.0"
  s.add_dependency "mini_magick", "~> 3.8"
  s.add_dependency "carrierwave", "~> 0.10"

  s.add_development_dependency "sqlite3"
end
