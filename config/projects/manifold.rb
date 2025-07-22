require_relative '../../util/clean_software.rb'
require_relative '../../util/read_version'
require_relative '../patches/cleanroom_ruby3'

name "manifold"
maintainer "Zach Davis, Cast Iron Coding"
homepage "https://github.com/manifoldScholar/manifold"

license "GPL-3.0"

replace   "manifold"
conflict  "manifold"

# /opt/manifold on all installable platforms
install_dir "#{default_root}/#{name}"

the_version = ReadVersion.('MANIFOLD_VERSION')
the_version = the_version[1..-1] if the_version.start_with? "v"
build_version the_version
build_iteration ReadVersion.build_iteration

# Centos has GCC 4.8, while recent icu needs 4.9 to compile.
if centos? && platform_version.start_with?("7")
  override :icu, version: "58.3"
else
  override :icu, version: "69.1"
end

dependency "chef"
override "chef", version: "v17.10.163"
dependency "icu" # For the Charlock Holmes Gem
dependency "rb-readline" # Needed for the rails console to work properly
dependency "preparation" # Creates required build directories
dependency "zlib"
dependency "openssl"
dependency "ruby"
dependency "chef-zero"
override "chef-zero", version: "15.0.4"
dependency "nginx"
dependency "runit"
dependency "redis"
dependency "pandoc-binary"
dependency "bundler"
dependency "nodejs-binary"
dependency "yarn"
dependency "libxml2"
dependency "ghostscript"
dependency "imagemagick"
dependency "postgresql"
dependency "logrotate"
dependency "omnibus-ctl"
override "omnibus-ctl", version: "v0.6.11"
dependency "manifold"
dependency "manifold-psql"
dependency "manifold-scripts"
dependency "manifold-ctl"
dependency "manifold-config-template"
dependency "manifold-cookbooks"
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
