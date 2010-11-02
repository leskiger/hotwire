# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hotwire}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Les Freeman"]
  s.date = %q{2010-11-02}
  s.description = %q{Hotwire is designed to ease the pain of creating Google Wire protocol compatible data source in Ruby.}
  s.email = %q{les@codebenders.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "hotwire.gemspec",
     "lib/hotwire.rb",
     "lib/hotwire/base.rb",
     "lib/hotwire/request.rb",
     "lib/hotwire/response.rb",
     "lib/hotwire/response/active_record_mixin.rb",
     "lib/hotwire/response/base.rb",
     "lib/hotwire/response/csv.rb",
     "lib/hotwire/response/html.rb",
     "lib/hotwire/response/invalid.rb",
     "lib/hotwire/response/json.rb",
     "test/active_record_test_helper.rb",
     "test/hotwire_test.rb",
     "test/response/test_active_record_mixin.rb",
     "test/response/test_base.rb",
     "test/response/test_csv.rb",
     "test/response/test_html.rb",
     "test/response/test_invalid.rb",
     "test/response/test_json.rb",
     "test/test_helper.rb",
     "test/test_request.rb",
     "test/test_response.rb"
  ]
  s.homepage = %q{http://github.com/lesfreeman/hotwire}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Under the hood data transformations for the Google Wire protocol.}
  s.test_files = [
    "test/active_record_test_helper.rb",
     "test/hotwire_test.rb",
     "test/response/test_active_record_mixin.rb",
     "test/response/test_base.rb",
     "test/response/test_csv.rb",
     "test/response/test_html.rb",
     "test/response/test_invalid.rb",
     "test/response/test_json.rb",
     "test/test_helper.rb",
     "test/test_request.rb",
     "test/test_response.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<redgreen>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<redgreen>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<redgreen>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end

