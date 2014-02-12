Gem::Specification.new do |s|
  s.name = "kitchen-cabinet"
  s.version = '1.0.1'
  s.date = Time.now.strftime("%m/%d/%Y")
  s.summary = 'Initializes a chef cookbook repo with relevant tools'
  s.description = <<EOF
`kitchen-cabinet` will create an opinionated chef cookbook skeleton complete with testing suite including:
    berkshelf, chefspec, test kitchen, strainer, foodcritic, rubocop, serverspec, stove, and guard. This is a refactor of the meez plugin with some extra additions.

EOF
  s.required_ruby_version = '>= 1.9.3'
  s.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  s.files = `git ls-files`.split($/)
  s.executables = [
    'cabinet'
  ]
  s.authors = ['Taylor Price']
  s.email   = 'tprice@onehealth.com'
  s.homepage = ''
  s.license = 'apache2'
  s.require_paths = ['lib']
  s.add_runtime_dependency 'chef', '~> 11.8.0'
  s.add_runtime_dependency 'test-kitchen', '~> 1.1.1'
  s.add_runtime_dependency 'bundler', '~> 1.5.1'
  s.add_runtime_dependency 'berkshelf', '~> 2.0.12'
  s.add_runtime_dependency 'git', '~> 1.2.6'
  s.add_runtime_dependency 'erubis', '~> 2.7.0'
  s.add_development_dependency 'rspec'
end
