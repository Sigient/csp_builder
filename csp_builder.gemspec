# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csp_builder/version'

Gem::Specification.new do |spec|
  spec.name          = 'csp_builder'
  spec.version       = CspBuilder::VERSION
  spec.authors       = ['Michael Coyne', 'Sigient']
  spec.email         = ['mikeycgto@gmail.com']

  spec.summary       = 'Content Security Policy string builder'
  spec.description   = 'Create rich Content Security Policies using this easy to use builder class'
  spec.homepage      = 'https://github.com/Sigient/csp_builder'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
