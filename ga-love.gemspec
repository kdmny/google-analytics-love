# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ga-love/version', __FILE__)

Gem::Specification.new do |s|
  s.add_development_dependency('rspec', '~> 2.4')
  s.add_development_dependency('yard') 
  s.authors = ["K$"]
  s.description = %q{A tool for generating click event tracking & cohorts using google analytics.}
  s.email = ['kdmny30@gmail.com']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/kdmny/ga-love'
  s.name = 'ga-love'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to? :required_rubygems_version=
  s.rubyforge_project = s.name
  s.summary = %q{A tool for generating click event tracking & cohorts using google analytics.}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = GaLove::VERSION
end
