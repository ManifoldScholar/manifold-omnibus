# config/software/nodejs.rb
# Override for Node.js 16.20.2

name "nodejs"
default_version "16.20.2"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

version "16.20.2" do
  source sha256: "874463523f26ed528634580247f403d200ba17a31adf2de98a7b124c6eb33d87"
end

source url: "https://nodejs.org/dist/v#{version}/node-v#{version}-linux-x64.tar.xz"
relative_path "node-v#{version}-linux-x64"

build do
  mkdir "#{install_dir}/embedded/nodejs"
  sync "#{project_dir}/", "#{install_dir}/embedded/nodejs"
  mkdir "#{install_dir}/bin"
  link "#{install_dir}/embedded/nodejs/bin/node", "#{install_dir}/bin/node"
end
