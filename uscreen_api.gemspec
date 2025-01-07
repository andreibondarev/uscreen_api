# frozen_string_literal: true

require_relative "lib/uscreen_api/version"

Gem::Specification.new do |spec|
  spec.name = "uscreen_api"
  spec.version = UscreenAPI::VERSION
  spec.authors = ["Andrei Bondarev"]
  spec.email = ["andrei.bondarev13@gmail.com"]

  spec.summary = "Uscreen.tv Publisher API client"
  spec.description = "Uscreen.tv Publisher API client"
  spec.homepage = "https://github.com/andreibondarev/uscreen_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andreibondarev/uscreen_api"
  spec.metadata["changelog_uri"] = "https://github.com/andreibondarev/uscreen_api/CHANGELOG.md"

  spec.files = Dir.glob(%w[lib/**/*.rb sig/**/*.rbs README.md LICENSE.txt])
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "yard"
end
