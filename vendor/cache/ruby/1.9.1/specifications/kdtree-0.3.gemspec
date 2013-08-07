# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "kdtree"
  s.version = "0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Doppelt"]
  s.date = "2012-10-17"
  s.description = "A kdtree is a data structure that makes it possible to quickly solve\nthe nearest neighbor problem. This is a native 2d kdtree suitable for\nproduction use with millions of points.\n"
  s.email = ["amd@gurge.com"]
  s.extensions = ["ext/kdtree/extconf.rb"]
  s.files = ["ext/kdtree/extconf.rb"]
  s.homepage = "http://github.com/gurgeous/kdtree"
  s.require_paths = ["lib"]
  s.rubyforge_project = "kdtree"
  s.rubygems_version = "2.0.6"
  s.summary = "Blazingly fast, native 2d kdtree."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0"])
  end
end
