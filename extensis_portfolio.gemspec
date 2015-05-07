# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extensis_portfolio/version'

Gem::Specification.new do |spec|
  spec.name          = "extensis_portfolio"
  spec.version       = ExtensisPortfolio::VERSION
  spec.authors       = ["Asger Behncke Jacobsen"]
  spec.email         = ["asger@8kilo.com"]

  spec.summary       = %q{A simple wrapper for the Extensis Portfolio API.}
  spec.description   = %q{A simple wrapper for the Extensis Portfolio API using the SOAP client Savon and the HTTP client Faraday.}
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  # end

  spec.add_dependency "savon", "~> 2.11.0"
  spec.add_dependency "faraday", "~> 0.9.1"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "minitest"
end
