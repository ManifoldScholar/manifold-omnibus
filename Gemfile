source 'https://rubygems.org'

# Install omnibus
gem 'omnibus', '~> 6.1.4', git: 'https://github.com/chef/omnibus'

# Use Chef's software definitions. It is recommended that you write your own
# software definitions, but you can clone/fork Chef's to get you started.
gem 'omnibus-software', github: 'opscode/omnibus-software'

gem 'active_interaction'
gem 'activesupport', '~> 6.0', require: false
gem 'attr_lazy'
gem 'cleanroom'
gem 'commander'
gem 'dotenv'
gem 'dux'
gem 'git'
gem 'jenkins_api_client'
gem 'rake'
gem 'rb-readline'
gem 'pry'
gem 'ptools'
gem 'rack', '>= 2.0.6'
gem 'rubyzip', '>= 1.2.2', '< 3.0'
gem 'semantic'

# This development group is installed by default when you run `bundle install`,
# but if you are using Omnibus in a CI-based infrastructure, you do not need
# the Test Kitchen-based build lab. You can skip these unnecessary dependencies
# by running `bundle install --without development` to speed up build times.
group :development do
  # Use Berkshelf for resolving cookbook dependencies
  gem 'berkshelf', '~> 6.0'
  # Use Test Kitchen with Vagrant for converging the build environment
  gem 'test-kitchen',    '~> 1.4'
  gem 'kitchen-vagrant', '~> 0.18'
end
