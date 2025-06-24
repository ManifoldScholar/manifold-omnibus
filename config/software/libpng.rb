name "libpng"

default_version '1.6.49'

license "libpng"
license_file "LICENSE"
skip_transitive_dependency_licensing true

dependency "config_guess"

version "1.6.49" do
  source sha512: 'c40e605c50f632b55809199cba40041b46b5b2ff37659e17dcd5ffe457d926532f3469151f99ad7aab898ef5bedf08ed134a0a4e7d00ac1e9c8cebe5b5eef9bc'
end

source url: "http://downloads.sourceforge.net/libpng/libpng-#{version}.tar.xz"

relative_path "libpng-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess(target: "config")

  # patch source: "animated.patch", env: env

  config_args = [
      "--prefix=#{install_dir}/embedded",
  ]

  command "./configure #{config_args.join(' ')}", env: env

  make "-j #{workers}", env: env
  make "test", env: env
  make "install", env: env
end
