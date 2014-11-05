require 'minitest/autorun'

Bundler.require

require 'vcr'
require 'mocha'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

AllSeeingPi.config.load_config_from_file('test/all_seeing_pi.yml')

AWS.config(
  access_key_id: AllSeeingPi.config[:aws_key],
  secret_access_key: AllSeeingPi.config[:aws_secret]
)
ENV['ALL_SEEING_PI_ENV'] = 'test'
