# Require test gems
require 'rspec'
require 'watir' # To set up a new Koinos User
require 'httparty'
require 'pry'

# Require the models and lib files
Dir[File.dirname(__FILE__) + '/../lib/*'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../features/support/models/*'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../features/support/helpers/*'].each { |f| require f }

RSpec.configure do |config|
  config.color_enabled = true
end

if ENV['HEADLESS']
  require 'headless'
  headless = Headless.new
  headless.start
end
