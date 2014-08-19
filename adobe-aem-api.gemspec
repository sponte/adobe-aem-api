# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adobe/aem/version'

Gem::Specification.new do |spec|
  spec.name          = 'adobe-aem-api'
  spec.version       = Adobe::Aem::VERSION
  spec.authors       = ['Stanislaw Wozniak']
  spec.email         = ['swozniak@sponte.co.uk']
  spec.summary       = %q{Adobe AEM Api gem}
  spec.description   = %q{Provides functionality to manage Adobe AEM instances.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'mocha', '~> 0.13.0'
  spec.add_development_dependency 'rr', '~> 1.0.4'
  spec.add_development_dependency 'flexmock', '~> 0.9.0'
  spec.add_development_dependency 'sinatra', '~>1.4.5'
  spec.add_development_dependency 'webmock', '~>1.18.0'
  spec.add_runtime_dependency 'recursive-open-struct'
  spec.add_runtime_dependency 'nokogiri'
end
