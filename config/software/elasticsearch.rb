#
# Copyright 2020 Chef Software, Inc.
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

name "elasticsearch"
default_version "7.17.15"

dependency "server-open-jre"
dependency "zlib"

license "Apache-2.0"
license_file "LICENSE.txt"
skip_transitive_dependency_licensing true


source url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{version}-linux-x86_64.tar.gz"
relative_path "elasticsearch-#{version}"

whitelist_file /libboost/
# x-pack-ml seems to use system libz. For now, commenting to avoid failing health check.
whitelist_file /x-pack-ml/

version "7.17.15" do
  source sha512: "58c85d0127236e7994f4e303b99899db0ca1b921a1bc40082c2383d632bc53f03a4c48f5b39fa7102530814d5f6f859364cd29d22a1024feaac4246d788789ed"
end

target_path = "#{install_dir}/embedded/elasticsearch"

build do
  mkdir  "#{target_path}"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  delete "#{project_dir}/config"
  delete "#{project_dir}/jdk"

  mkdir  "#{project_dir}/plugins"
  # by default RPMs will not include empty directories in the final package
  # ES will fail to start if this dir is not present.
  touch  "#{project_dir}/plugins/.gitkeep"

  sync   "#{project_dir}/", "#{target_path}"

  # Dropping a VERSION file here allows additional software definitions
  # to read it to determine ES plugin compatibility.
  command "echo #{version} > #{target_path}/VERSION"
end
