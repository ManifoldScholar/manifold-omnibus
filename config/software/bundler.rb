name "bundler"
default_version "2.4.19"

license "MIT"
license_file "https://raw.githubusercontent.com/rubygems/bundler/main/LICENSE.md"
skip_transitive_dependency_licensing true

# Bundler is installed as a gem, so we use the gem installer
build do
  gem "install bundler --version #{version} --no-document --force"
end
