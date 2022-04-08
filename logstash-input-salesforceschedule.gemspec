@@ -21,9 +21,11 @@ Gem::Specification.new do |s|
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"
  s.add_runtime_dependency "logstash-codec-plain"
  s.add_runtime_dependency "restforce", ">= 5", "< 5.2"
  s.add_runtime_dependency 'rufus-scheduler'
  s.add_development_dependency 'logstash-devutils'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'json'
  s.add_development_dependency 'public_suffix', '>= 1.4' # required due to ruby < 2.0
  s.add_development_dependency 'timecop'
end
