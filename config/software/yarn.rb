name "yarn"
default_version "1.22.5"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "nodejs-binary"

version "1.22.19" do
  source sha512: "ff4579ab459bb25aa7c0ff75b62acebe576f6084b36aa842971cf250a5d8c6cd3bc9420b22ce63c7f93a0857bc6ef29291db39c3e7a23aab5adfd5a4dd6c5d71"
end

source url: "https://github.com/yarnpkg/yarn/releases/download/v#{version}/yarn-v#{version}.tar.gz"

build do
  copy "#{project_dir}/yarn-v#{version}/bin/*", "#{install_dir}/embedded/bin/"
  copy "#{project_dir}/yarn-v#{version}/lib/*", "#{install_dir}/embedded/lib/"
end
