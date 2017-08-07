#
# Copyright 2017 YOUR NAME
#
# All Rights Reserved.
#

name "manifold"
maintainer "Zach Davis, Cast Iron Coding"
homepage "https://github.com/manifoldScholar/manifold"

license "MIT"

replace   "manifold"
conflict  "manifold"

# Defaults to C:/manifold on Windows
# and /opt/manifold on all other platforms
install_dir "#{default_root}/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

# manifold dependencies/components
dependency "nodejs-binary"
dependency "chef-gem"
dependency "chef-zero"
dependency "openssl"
dependency "nginx"
dependency "runit"
dependency "redis"
dependency "postgresql"
dependency "yarn"
dependency "ruby"
dependency "bundler"
dependency "libxml2"
dependency "yarn"
dependency "logrotate"
dependency "elasticsearch"
dependency "manifold-ctl"
dependency "manifold-cookbooks"
dependency "manifold-config-template"
dependency "manifold-psql"
dependency "manifold-scripts"
dependency "manifold"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"

override :nodejs, version: "6.10.3"
override :ruby, version: "2.3.3"
override :libtool, version: "2.4.2"
override :rubygems, version: "2.6.12"
override :bundler, version: "1.15.3"
override "rb-readline", version: "v0.5.5"