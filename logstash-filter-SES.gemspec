Gem::Specification.new do |s|
  s.name = 'logstash-filter-SES'
  s.version = '2.0.0'
  s.licenses = ['Stormshield']
  s.summary = "SES filter."
  s.description = "SES filter"
  s.authors = ["Apache License (2.0)"]
  s.email = 'svc@stormshield.eu'
  s.homepage = "https://www.stormshield.eu"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency 'logstash-core-plugin-api', '>= 1.60', '<= 2.99'
  s.add_development_dependency "logstash-devutils", "= 1.3.4"
end
