name "libtiff"

default_version '4.7.0'

dependency "config_guess"

license 'MIT'
license_file 'COPYRIGHT'

version '4.7.0' do
  source sha512: 'a77a050d1d8777c6d86077c3c26e8d35f98717fe14bb3c049e2b82fbfbb374e96f83a0c1ff67ffb21591a9a7abf0d3e18c3d7695c96939326cc19a9712dd2492'
end

source url: "http://download.osgeo.org/libtiff/tiff-#{version}.tar.gz"

relative_path "tiff-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess(target: "config")

  config_args = [
      "--prefix=#{install_dir}/embedded",
  ]

  command "./configure #{config_args.join(' ')}", env: env

  make "-j #{workers}", env: env
  make "check", env: env
  make "install", env: env
end
