# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mailboxer"
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eduardo Casanova Cuesta"]
  s.date = "2013-08-23"
  s.description = "A Rails engine that allows any model to act as messageable, adding the ability to exchange messages with any other messageable model, even different ones. It supports the use of conversations with two or more recipients to organize the messages. You have a complete use of a mailbox object for each messageable model that manages an inbox, sentbox and trash for conversations. It also supports sending notifications to messageable models, intended to be used as system notifications."
  s.email = "ecasanovac@gmail.com"
  s.homepage = "https://github.com/ging/mailboxer"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Messaging system for rails apps."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<foreigner>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<rails>, ["> 3.0.0"])
      s.add_runtime_dependency(%q<carrierwave>, [">= 0.5.8"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, ["~> 2.6.0"])
      s.add_development_dependency(%q<forgery>, [">= 0.3.6"])
      s.add_development_dependency(%q<capybara>, [">= 0.3.9"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<foreigner>, [">= 0.9.1"])
      s.add_dependency(%q<rails>, ["> 3.0.0"])
      s.add_dependency(%q<carrierwave>, [">= 0.5.8"])
      s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<factory_girl>, ["~> 2.6.0"])
      s.add_dependency(%q<forgery>, [">= 0.3.6"])
      s.add_dependency(%q<capybara>, [">= 0.3.9"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<foreigner>, [">= 0.9.1"])
    s.add_dependency(%q<rails>, ["> 3.0.0"])
    s.add_dependency(%q<carrierwave>, [">= 0.5.8"])
    s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<factory_girl>, ["~> 2.6.0"])
    s.add_dependency(%q<forgery>, [">= 0.3.6"])
    s.add_dependency(%q<capybara>, [">= 0.3.9"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
