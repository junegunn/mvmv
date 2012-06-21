# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mvmv/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Junegunn Choi"]
  gem.email         = ["junegunn.c@gmail.com"]
  gem.description   = %q{Rename a series of files easily}
  gem.summary       = %q{Rename a series of files easily}
  gem.homepage      = "https://github.com/junegunn/mvmv"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mvmv"
  gem.require_paths = ["lib"]
  gem.version       = Mvmv::VERSION
  gem.add_runtime_dependency 'ansi', '~> 1.4.2'
  gem.add_development_dependency 'test-unit'
end
