# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "action_mailer_cache_delivery/version"

Gem::Specification.new do |s|
  s.name        = "action_mailer_cache_delivery"
  s.author      = "ngty77@gmail.com"
  s.version     = ActionMailerCacheDelivery::VERSION
  s.summary     = %q{Gem-ized version of action_mailer_cache_delivery}
  s.description = %q{It's a gem}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.authors = ["Telmate LLC"]
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
