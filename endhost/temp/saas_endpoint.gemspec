# gem build saas_endpoint.gemspec
# gem install ./saas_endpoint-0.0.1.gem

Gem::Specification.new do |s|
  s.name        = 'saas_endpoint'
  s.version     = '0.0.1'
  s.date        = '2013-10-15'
  s.summary     = "APM software as a service"
  s.description = "APM software as a service."
  s.authors     = ["Dean Okamura"]
  s.email       = 'dokamura@us.ibm.com'
  s.files       = ['lib/saas_endpoint.rb']
  s.homepage    = 'http://rubygems.org/gems/saas_endpoint'
  s.license     = 'MIT'
end
