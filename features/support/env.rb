# require 'fileutils'
require 'cucumber'
require 'rspec/expectations'
require 'watir'
require 'yaml'

# Test development and debugging gems
require 'pry'
require 'rubocop'

require 'yaml'

# Load the generic libraries in lib..
require File.dirname(__FILE__) + '/../../lib/env_config.rb'
Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |f| require f }

require File.dirname(__FILE__) + '/pages/generic.rb'
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |f| require f }

Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each { |f| require f }

# Set up World
World(RSpec::Matchers)
