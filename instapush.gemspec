# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{instapush}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kim Joar Bekkelund"]
  s.date = %q{2010-07-27}
  s.description = %q{Ruby wrapper for the Instapaper API.}
  s.email = %q{kjbekkelund@gmail.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
     "VERSION",
     "lib/instapush.rb",
     "spec/instapush_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kjbekkelund/instapush}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby wrapper for the Instapaper API.}
  s.test_files = [
    "spec/instapush_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rest_client>, [">= 1"])
    else
      s.add_dependency(%q<rest_client>, [">= 1"])
    end
  else
    s.add_dependency(%q<rest_client>, [">= 1"])
  end
end

