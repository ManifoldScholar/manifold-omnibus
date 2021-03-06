CURRENT_PATH  = File.expand_path(File.dirname(__FILE__))
TIME          = Time.now.to_i

file_cache_path "#{CURRENT_PATH}/cache"
cookbook_path   CURRENT_PATH
cache_path      "#{CURRENT_PATH}/cache"
verbose_logging false
ssl_verify_mode :verify_peer
log_location    "#{CURRENT_PATH}/reconfigure.#{TIME}.log"
log_level       :info
# Omnibus-manifold only needs to know very little about the system it is running
# on. We want to disable as many Ohai plugins as we can to avoid plugin bugs
# and speed up 'manifold-ctl reconfigure'.
#
# The list below, based on Ohai 7.4.1, is a blacklist. UNcomment a plugin to
# disable it. For example, ':Groovy,' is uncommented because omnibus-manifold
# does not care about Groovy.
ohai.disabled_plugins = [
  :Azure,
  :Cloud,
  :CloudV2,
  :DMI,
  :DigitalOcean,
  :EC2,
  :Erlang,
  :Elixir,
  :Eucalyptus,
  :GCE,
  :Groovy,
  :Go,
  :Java,
  :Joyent,
  :Linode,
  :Lua,
  :Mono,
  :NetworkListeners,
  :NetworkRoutes,
  :Nodejs,
  :Openstack,
  :Perl,
  :PHP,
  :Powershell,
  :Python,
  :Rackspace,
  :Rust,
  :Virtualbox,
  :VMware,
  :SystemProfile,
  :Zpools,
  :Virtualization
]
