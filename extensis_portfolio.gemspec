# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extensis_portfolio/version'

Gem::Specification.new do |spec|
  spec.name          = 'extensis_portfolio'
  spec.version       = ExtensisPortfolio::VERSION
  spec.authors       = ['Tomáš Celizna', 'Asger Behncke Jacobsen']
  spec.email         = ['mail@tomascelizna.com', 'asger@8kilo.com']

  spec.summary       = 'A simple wrapper for the Extensis Portfolio API.'
  spec.description   = 'A simple wrapper for the Extensis Portfolio API using the SOAP client Savon and the HTTP client Faraday.'
  spec.homepage      = 'https://github.com/tomasc/extensis_portfolio'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'savon', '~> 2.11'
  spec.add_dependency 'faraday', '~> 0.9'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-vcr'
  spec.add_development_dependency 'webmock'
end
