require_relative "lib/solder/version"

Gem::Specification.new do |spec|
  spec.name = "solder"
  spec.version = Solder::VERSION
  spec.authors = ["Julian Rubisch"]
  spec.email = ["julian@julianrubisch.at"]
  spec.homepage = "https://github.com/julianrubisch/solder"
  spec.summary = "Simplistic UI State Management for Rails Apps using Hotwire and Caching"
  spec.description = "Simplistic UI State Management for Rails Apps using Hotwire and Caching"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"
  spec.add_dependency "stimulus-rails", ">= 1.1"
  spec.add_dependency "turbo-rails", ">= 1.1"

  spec.add_development_dependency "solargraph-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "standard"
end
