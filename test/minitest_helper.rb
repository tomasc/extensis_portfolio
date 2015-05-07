$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "bundler/setup"

require "minitest"
require "minitest/autorun"
require "minitest/spec"

require "savon"
require "faraday"
require "extensis_portfolio"
