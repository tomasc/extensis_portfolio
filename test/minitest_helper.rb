$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'

require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

require 'savon'
require 'faraday'
require 'extensis_portfolio'

ENV['SERVER'] = 'http://playground.extensis.com:8090'
ENV['USERNAME'] = 'USERNAME'
ENV['PASSWORD'] = '???????????????'
ENV['CATALOG_ID'] = 'DB422C34-4943-9496-F301-B781AAB574BA'

require 'minitest-vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end
