name "libjpeg"

default_version '9d'

version '9d' do
  source sha512: "c64d3ee269367351211c077a64b2395f2cfa49b9f8257fae62fa1851dc77933a44b436d8c70ceb52b73a5bedff6dbe560cc5d6e3ed5f2997d724e2ede9582bc3"
end

source url: "http://www.ijg.org/files/jpegsrc.v#{version}.tar.gz"

relative_path "jpeg-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess(target: "config")

  config_args = [
      "--prefix=#{install_dir}/embedded",
  ]

  command "./configure #{config_args.join(' ')}", env: env

  make "-j #{workers}", env: env
  # make "test", env: env
  make "install", env: env
end
