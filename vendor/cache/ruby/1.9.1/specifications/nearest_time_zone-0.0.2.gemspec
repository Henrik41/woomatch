# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "nearest_time_zone"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Devine"]
  s.date = "2013-05-20"
  s.description = "Quickly find the name of a time zone for a latitude and longitude without relying on a web service."
  s.email = ["seandevine@gopartage.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Quickly find the name of a time zone for a latitude and longitude without relying on a web service."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<terminal-notifier-guard>, [">= 0"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
      s.add_runtime_dependency(%q<require_all>, [">= 0"])
      s.add_runtime_dependency(%q<kdtree>, [">= 0"])
      s.add_runtime_dependency(%q<andand>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<terminal-notifier-guard>, [">= 0"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
      s.add_dependency(%q<debugger>, [">= 0"])
      s.add_dependency(%q<require_all>, [">= 0"])
      s.add_dependency(%q<kdtree>, [">= 0"])
      s.add_dependency(%q<andand>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<terminal-notifier-guard>, [">= 0"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9.1"])
    s.add_dependency(%q<debugger>, [">= 0"])
    s.add_dependency(%q<require_all>, [">= 0"])
    s.add_dependency(%q<kdtree>, [">= 0"])
    s.add_dependency(%q<andand>, [">= 0"])
  end
end
