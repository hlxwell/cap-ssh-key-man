# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cap-ssh-key-man/version"

Gem::Specification.new do |s|
  s.name        = "cap-ssh-key-man"
  s.version     = Cap::Ssh::Key::Man::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael He"]
  s.email       = ["hlxwell@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This tool is used to mass deploy ssh-keys to all your servers according to the capistrano config.}
  s.description = %q{This tool is used to mass deploy ssh-keys to all your servers according to the capistrano config.}

  s.rubyforge_project = "cap-ssh-key-man"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
