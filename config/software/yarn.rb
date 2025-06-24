name "yarn"
default_version "1.22.22"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "nodejs-binary"

version "1.22.22" do
  source sha512: "c8b361ca353e3ca15e32eadf7f1617449f485fe488860e49774ea35dac1544f39ab1104f82bf24528de6e553eef53c4604a560e522dfab8433425ee13ccfd6f9"
end

source url: "https://github.com/yarnpkg/yarn/releases/download/v#{version}/yarn-v#{version}.tar.gz"

build do
  copy "#{project_dir}/yarn-v#{version}/bin/*", "#{install_dir}/embedded/bin/"
  copy "#{project_dir}/yarn-v#{version}/lib/*", "#{install_dir}/embedded/lib/"
end
