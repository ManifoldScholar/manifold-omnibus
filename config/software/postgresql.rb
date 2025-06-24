#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "postgresql"
default_version "13.21"

license "PostgreSQL"
license_file "COPYRIGHT"
skip_transitive_dependency_licensing true

dependency "zlib"
dependency "openssl"
dependency "libedit"
dependency "ncurses"
dependency "config_guess"

if osx?
  dependency "libossp-uuid"
else
  dependency "libuuid"
end

version "13.21" do
  source sha256: "37d3e26304ef379934f9c15111bb982f5242ea18a4c783a87caa1389af6b1f4d",
         url: "https://ftp.postgresql.org/pub/source/v13.21/postgresql-13.21.tar.gz"
  end

source url: "https://ftp.postgresql.org/pub/source/v#{version}/postgresql-#{version}.tar.gz"

relative_path "postgresql-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  prefix = "#{install_dir}/embedded/postgresql/#{version}"

  update_config_guess(target: "config")

  config_args = [
    "--prefix=#{prefix}",
    "--with-libedit-preferred",
    "--with-openssl",
    "--with-includes=#{install_dir}/embedded/include",
    "--with-libraries=#{install_dir}/embedded/lib",
    "--with-uuid=e2fs"
  ]

  command "./configure #{config_args.join(' ')}", env: env

  make "world -j #{workers}", env: env
  make "install-world", env: env

  block 'link bin files' do
    Dir.glob("#{prefix}/bin/*").each do |bin_file|
      link bin_file, "#{install_dir}/embedded/bin/#{File.basename(bin_file)}"
    end
  end
end
