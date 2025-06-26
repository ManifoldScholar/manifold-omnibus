#!/bin/bash
set -e

# Read Ruby version from .ruby-version file
if [ -f "/vagrant/.ruby-version" ]; then
  RUBY_VERSION=$(cat /vagrant/.ruby-version | tr -d '[:space:]')
  echo "Installing Ruby version: $RUBY_VERSION"
else
  echo "No .ruby-version file found in /vagrant/, defaulting to 3.2.3"
  RUBY_VERSION="3.2.3"
fi

# Install dependencies
apt-get update
apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev libffi-dev libyaml-dev

# Install rbenv if not present
if [ ! -d "/home/vagrant/.rbenv" ]; then
  echo "Installing rbenv..."
  git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
  git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
  chown -R vagrant:vagrant /home/vagrant/.rbenv
fi

# Install the specified Ruby version
echo "Installing Ruby $RUBY_VERSION..."
su - vagrant -c "
  export PATH=\"\$HOME/.rbenv/bin:\$PATH\"
  eval \"\$(rbenv init -)\"

  if ! rbenv versions | grep -q \"$RUBY_VERSION\"; then
    rbenv install $RUBY_VERSION
  else
    echo \"Ruby $RUBY_VERSION already installed\"
  fi

  rbenv global $RUBY_VERSION
  rbenv rehash
  gem install bundler
  rbenv rehash
"

# Create a wrapper script that forces rbenv Ruby
echo "Creating Ruby wrapper scripts..."
cat > /usr/local/bin/ruby << 'EOF'
#!/bin/bash
export PATH="/home/vagrant/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
exec /home/vagrant/.rbenv/shims/ruby "$@"
EOF

cat > /usr/local/bin/gem << 'EOF'
#!/bin/bash
export PATH="/home/vagrant/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
exec /home/vagrant/.rbenv/shims/gem "$@"
EOF

cat > /usr/local/bin/bundle << 'EOF'
#!/bin/bash
export PATH="/home/vagrant/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
exec /home/vagrant/.rbenv/shims/bundle "$@"
EOF

chmod +x /usr/local/bin/ruby /usr/local/bin/gem /usr/local/bin/bundle

# Fix omnibus toolchain permissions
echo "Fixing omnibus toolchain permissions..."
chown -R vagrant:vagrant /opt/omnibus-toolchain/embedded/ || true

# Add rbenv initialization to all shell configurations
for file in /home/vagrant/.bashrc /home/vagrant/.bash_profile /home/vagrant/.profile; do
  if ! grep -q 'rbenv' "$file" 2>/dev/null; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> "$file"
    echo 'eval "$(rbenv init -)"' >> "$file"
  fi
done

echo "Ruby $RUBY_VERSION installation complete!"
