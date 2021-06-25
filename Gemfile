source "https://rubygems.org"

# Specify your gem's dependencies in activerecord-normalizations.gemspec
gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

version = case rails_version
when 'master'
  { github: 'rails/rails' }
when "default"
  '~> 6.1.3'
else
  "~> #{rails_version}"
end

gem 'activerecord', version
gem 'activesupport', version
