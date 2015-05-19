ENV["RAILS_ENV"] ||= 'test'
require "pludoni/coverage"
require 'spec_helper'


require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "pludoni/spec-helper"
ActiveRecord::Migration.maintain_test_schema!

require 'pludoni/database-cleaner'


RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.backtrace_exclusion_patterns << %r{/gems/ruby}
end
