# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'idoru/version'

Gem::Specification.new do |spec|
  spec.name          = 'idoru'
  spec.version       = Idoru::VERSION
  spec.authors       = ['Robert D. Birch']
  spec.email         = ['robdbirch@gmail.com']

  spec.summary       = 'Framework to manage API AI webhook fulfillments'
  spec.description   = %q{
                          Idoru is used to help manage API AI projects.
                          Provides a controller/view idiom for dispatching http
                          requests based on the API Bot name and an intent's defined
                          action}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'puma', '~> 3.10'
  spec.add_runtime_dependency 'awesome_print', '~> 1.8'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rack-test', '~> 0.7.0'
end
