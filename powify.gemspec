# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'powify'
  s.version     = '0.8.5'
  s.author    	= 'Seth Vargo'
  s.email       = 'sethvargo@gmail.com'
  s.homepage    = 'https://github.com/sethvargo/powify'
  s.summary     = %q{Powify is an easy-to-use wrapper for 37 signal's pow}
  s.description = %q{Powify provides an easy wrapper for use with 37 signal's pow. Use this gem to easily install and update pow server. Easily create, destroy, and manage pow apps.}

  s.rubyforge_project = 'powify'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'json'
end