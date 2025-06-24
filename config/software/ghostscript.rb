name "ghostscript"

default_version '10.05.1'

license "AGPL-3.0"
license_file "LICENSE"
skip_transitive_dependency_licensing true

version "10.05.1" do
  source sha512: '004b913291871133cfd1e6ddef541f9fc29da766547e871b2143c8ccfa9167efba704dac2618ebee5d8f5a07d8df0eb70ff174fd6c400b152c6b8512dae68ba5'
  source url: "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10051/ghostpdl-10.05.1.tar.gz"
end

relative_path "ghostpdl-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess(target: "config")

  config_args = [
    "--prefix=#{install_dir}/embedded",
    "--without-tesseract"   # Tesseract breaks make install on Centos7
  ]

  command "./configure #{config_args.join(' ')}", env: env

  make "install", env: env
end
