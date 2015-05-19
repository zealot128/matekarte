source 'https://rubygems.org'
if Gem::Version.new(Bundler::VERSION) < Gem::Version.new('1.9.0')
  abort "Bundler version >= 1.9.0 is required"
end


gem 'rails', '~> 4.2.1'
gem 'bcrypt', '~> 3.1.7'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'simple_form'
gem 'oj'
gem 'geocoder'
gem 'slim-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-leaflet'
  gem 'rails-assets-backbone'
  gem 'rails-assets-toastr'
  gem 'rails-assets-bootstrap-modal'
  gem 'rails-assets-Leaflet.awesome-markers'
end

gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'sprockets-es6'
gem 'font-awesome-rails'
gem 'quiet_assets', group: :development

gem 'stringex'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'pludoni-spec', git: 'https://github.com/pludoni/pludoni-spec.git'
end

group :production do
  gem 'redis-rails'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
end
