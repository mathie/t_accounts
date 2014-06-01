source 'http://rubygems.org'

ruby File.read(File.expand_path('../.ruby-version', __FILE__)).chomp

gem 'rails', '~>3.1.0'
gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'simple_form'
gem 'rdiscount'
gem 'thin'
gem 'devise', '~> 1.4.4'
gem 'kaminari'

group :development do
  gem 'faker'
end

group :development, :test do
  gem 'turn', :require => false
end
