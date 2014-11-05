require 'test_helper'

class ConfigurationTest < MiniTest::Unit::TestCase
  def setup
    @config = AllSeeingPi.config
  end

  def test_load_config_from_file
    filename = 'test_config.yml'
    File.write(filename, "aws_key: totally_fake")

    @config.load_config_from_file('test_config.yml')

    assert_equal 'totally_fake', AllSeeingPi.config[:aws_key]
  ensure
    FileUtils.rm(filename)
  end
end
