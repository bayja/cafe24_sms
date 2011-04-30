# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cafe24_sms/version"

Gem::Specification.new do |s|
  s.add_development_dependency('rspec')
  s.add_development_dependency('autotest')
  s.add_development_dependency('webmock')

  s.name        = "cafe24_sms"
  s.version     = Cafe24Sms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["bayja"]
  s.email       = ["potato9@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{카페24 sms 사용을 위한 gem}
  s.description = %q{카페24 sms 사용을 위한 gem}

  s.rubyforge_project = "cafe24_sms"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end