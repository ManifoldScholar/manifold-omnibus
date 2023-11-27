name "imagemagick"
default_version "7.1.1-21"

license "ImageMagick"
license_file "LICENSE"
skip_transitive_dependency_licensing true

dependency "config_guess"

dependency "bzip2"
dependency "libpng"
dependency "libjpeg"
dependency "liblzma"
dependency "libtiff"
dependency "libxml2"
dependency "zlib"
dependency "ghostscript"

version '7.1.1-21' do
  source sha512: 'fd74f50b10a9406180bcdce91b59a3ce2d7803c162d2b9bbf0093e3f939c3c63c17abfddc692ce972f7e0c43123c68e5bbb7ef0867f433e51c906a28f1826049'
end

source url: "https://github.com/ImageMagick/ImageMagick/archive/refs/tags/#{version}.tar.gz"

relative_path "ImageMagick-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess(target: "config")

  #--disable-dependency-tracking
  # Build without C++ interface, graphviz, ghostscript, freetype, perl
  # Basically: nothing we won't need to resize images
  config_args = %W[
    --prefix=#{install_dir}/embedded
    --disable-silent-rules
    --enable-shared
    --enable-static
    --disable-opencl
    --disable-openmp
    --enable-hdri
    --without-magick-plus-plus
    --without-perl
    --without-x
    --without-pango
    --without-lcms
    --without-gvc
    --without-freetype
  ]

  config_args.unshift("--disable-osx-universal-binary") if mac_os_x?

  command "./configure #{config_args.join(' ')}", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
