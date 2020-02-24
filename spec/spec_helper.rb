# Loading dependencies and requirements for the tests
require 'rspec'
require 'yaml'
require 'pry'
require 'rest-client'
require 'erb'
require_relative './helpers/request'
require_relative './helpers/schema_validator'

# Load data used for tests as DATA
DATA = YAML.load_file('./data/data.yaml')

