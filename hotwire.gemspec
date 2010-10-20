# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hotwire}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Les Freeman"]
  s.date = %q{2010-10-19}
  s.description = %q{Hotwire is designed to ease the pain of creating Google Wire protocol compatible data source in Ruby.}
  s.email = %q{les@codebenders.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "hotwire.gemspec",
     "lib/hotwire.rb",
     "lib/hotwire/active_record_mixin.rb",
     "lib/hotwire/column_headers.rb",
     "lib/hotwire/core_extensions.rb",
     "lib/hotwire/data.rb",
     "lib/hotwire/row.rb",
     "test/active_record_test_helper.rb",
     "test/hotwire_test.rb",
     "test/test_active_record_mixin.rb",
     "test/test_column_headers.rb",
     "test/test_core_extensions.rb",
     "test/test_data.rb",
     "test/test_helper.rb",
     "test/test_row.rb"
  ]
  s.homepage = %q{http://github.com/lesfreeman/hotwire}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Under the hood data transformations for the Google Wire protocol.}
  s.test_files = [
    "test/active_record_test_helper.rb",
     "test/hotwire_test.rb",
     "test/test_active_record_mixin.rb",
     "test/test_column_headers.rb",
     "test/test_core_extensions.rb",
     "test/test_data.rb",
     "test/test_helper.rb",
     "test/test_row.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<redgreen>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<redgreen>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<redgreen>, [">= 0"])
  end
end
