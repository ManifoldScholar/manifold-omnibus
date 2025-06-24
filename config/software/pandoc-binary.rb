name "pandoc-binary"
default_version "3.7.0.2"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

version "3.7.0.2" do
  source sha256: "8f8f67fdd540b6519326b0ac49d5c55c5d5d15e43920e80a086e02c8aff83268"
end

source url: "https://github.com/jgm/pandoc/releases/download/#{version}/pandoc-#{version}-linux-amd64.tar.gz"
relative_path "pandoc-#{version}"

build do
  mkdir "#{install_dir}/bin/"

  copy "#{project_dir}/bin/pandoc", "#{install_dir}/bin"
  # Note: pandoc-citeproc was deprecated in Pandoc 2.11+
  # It's now built into pandoc itself, so this line may not be needed:
  # copy "#{project_dir}/bin/pandoc-citeproc", "#{install_dir}/bin"

  # Copy pandoc-lua and pandoc-server if they exist in newer versions
  %w{pandoc-lua pandoc-server}.each do |binary|
    copy "#{project_dir}/bin/#{binary}", "#{install_dir}/bin" if File.exist?("#{project_dir}/bin/#{binary}")
  end
end
