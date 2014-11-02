require 'minitest/autorun'

Bundler.require

require 'mocha'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

AWS.config(YAML.load_file('test/aws.yml'))
