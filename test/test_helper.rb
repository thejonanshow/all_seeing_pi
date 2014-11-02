require 'minitest/autorun'

Bundler.require

require 'vcr'
require 'mocha'
require 'phashion'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

AWS.config(YAML.load_file('test/aws.yml'))
