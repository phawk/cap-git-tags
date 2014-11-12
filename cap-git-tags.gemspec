# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/git_tags/version'

Gem::Specification.new do |spec|
  spec.name          = "cap-git-tags"
  spec.version       = Capistrano::GitTags::VERSION
  spec.authors       = ["Pete Hawkins", "Adrian Dugan"]
  spec.email         = ["pete@phawk.co.uk", "rant@dugg.ie"]
  spec.description   = %q{This is a capistrano 3 plugin for auto tagging your git deploys.}
  spec.summary       = %q{Auto tags staging and production deploys for git projects}
  spec.homepage      = "https://github.com/phawk/cap-git-tags"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
