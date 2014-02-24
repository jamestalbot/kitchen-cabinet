source 'https://rubygems.org'

gem 'berkshelf', '~> 2.0', '>= 2.0.14'
gem 'chef', '~> 11.8', '>= 11.8.0'

group :unit do
  gem 'foodcritic',       '~> 3', '>= 3.0.0'
  gem 'rubocop',          '~> 0.18', '>= 0.18.0'
  gem 'chefspec',         '~> 3.2', '>= 3.2.0'
end

group :integration do
  gem 'test-kitchen',    '~> 1.1', '>= 1.1.0'
  gem 'kitchen-vagrant', '~> 0', '>= 0.14.0'
end

group :release do
  gem 'stove', '~> 1.1', '>= 1.1.0'
  gem 'rspec_junit_formatter'
  gem 'rubocop-checkstyle_formatter'
end

group :development do
  gem 'rake',     			  '~> 10.1', '>= 10.1.0'
  gem 'serverspec',       '~> 0.14', '>= 0.14.2'
  gem 'guard',            '~> 1.8', '>= 1.8.3'
  gem 'guard-rubocop',    '~> 0.2', '>= 0.2.2'
  gem 'guard-foodcritic', '~> 1.0', '>= 1.0.0'
  gem 'guard-kitchen',    '~> 0.0', '>= 0.0.0'
  gem 'guard-rspec',      '~> 3.1', '>= 3.1.0'
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'terminal-notifier-guard', :require => false
end
