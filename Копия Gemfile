source 'https://rubygems.org'

ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0

gem 'rails', '4.0.0'

gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.1.2'

# Pagination
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
#gem 'will_paginate-bootstrap'

# XLS import
gem 'roo'

# HTML parsing
gem 'nokogiri'

# String similarity
gem "jaccard", "~> 1.0.2"

# Workers
gem 'sidekiq'
gem 'sinatra', require: false

gem 'slim'

# Monitoring
gem 'newrelic_rpm'

gem 'unicorn'

# Database access
gem 'pg', '0.15.1'

# Bootstrap
gem 'sass-rails', '4.0.0'
gem 'bootstrap-sass', '~> 3.0.2.0'

gem 'coffee-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :development, :test do
	gem 'rspec-rails', '2.13.1'
	gem 'guard-rspec', '2.5.0'
	gem 'spork-rails', '4.0.0'
	gem 'guard-spork', '1.5.0'
	gem 'childprocess', '0.3.6'
end

group :test do
	gem 'selenium-webdriver', '2.35.1'
	gem 'capybara', '2.1.0'
	gem 'factory_girl_rails', '4.2.0'
	gem 'cucumber-rails', '1.4.0', require: false
	gem 'database_cleaner', github: 'bmabey/database_cleaner'
	gem 'growl', '1.0.3'
end

group :doc do
	gem 'sdoc', '0.3.20', require: false
end

group :production do
	gem 'rails_12factor', '0.0.2'
end