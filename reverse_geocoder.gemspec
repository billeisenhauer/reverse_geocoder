# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{reverse_geocoder}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bill Eisenhauer"]
  s.date = %q{2009-12-06}
  s.description = %q{ReverseGeocoder Gem}
  s.email = ["bill@billeisenhauer.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/reverse_geocoder.rb", "lib/reverse_geocoder/exceptions.rb", "lib/reverse_geocoder/geocoder.rb", "lib/reverse_geocoder/geonames.rb", "lib/reverse_geocoder/geoplugin.rb", "lib/reverse_geocoder/google.rb", "lib/reverse_geocoder/ibegin.rb", "lib/reverse_geocoder/multi.rb", "lib/reverse_geocoder/numerex.rb", "lib/reverse_geocoder/version.rb", "script/console", "script/destroy", "script/generate", "spec/geocoder_spec.rb", "spec/geonames_spec.rb", "spec/geoplugin_spec.rb", "spec/google_spec.rb", "spec/ibegin_spec.rb", "spec/multi_spec.rb", "spec/numerex_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.homepage = %q{http://github.com/billeisenhauer/reverse_geocoder}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{reverse_geocoder}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby gem containing production-quality reverse geocoding client service.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
