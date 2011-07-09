source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Yes, I am insane, I know. It's to do with Lion shipping a neutered copy of
# PostgreSQL and me being stupid enough to use the Lion DPs.
group :development, :test do
  gem 'mysql2'
end
group :production do
  gem 'pg'
end

# Asset template engines
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

gem 'simple_form'

gem 'rdiscount'
gem 'foreman'
gem 'thin'

group :development do
  gem 'heroku', :require => false
end

# FIXME: Hack to give me a JS runtime in production; can be removed once rc5
# is released.
group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'machinist', '>= 2.0.0.beta2'
end
