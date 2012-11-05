# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fropy/version'

Gem::Specification.new do |gem|
  gem.name          = "fropy"
  gem.version       = Fropy::VERSION
  gem.authors       = ["Utkarsh Kukreti"]
  gem.email         = ["utkarshkukreti@gmail.com"]
  gem.description   = %q{Process memory and cpu time benchmarker}
  gem.summary       = %q{Process memory and cpu time benchmarker}
  gem.homepage      = "https://github.com/utkarshkukreti/fropy"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "docopt"
end
