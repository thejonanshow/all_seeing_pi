require 'minitest/autorun'

Bundler.require

require 'vcr'
require 'mocha'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

AWS.config(YAML.load_file('test/aws.yml'))

ENV['ALL_SEEING_PI_ENV'] = 'test'
