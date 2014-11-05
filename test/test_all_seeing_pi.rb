require 'test_helper'

class AllSeeingPiTest < MiniTest::Unit::TestCase
  def setup
    @config = AllSeeingPi.config
  end

  def teardown
    AllSeeingPi.config.reset!
  end

  def test_config_with_block
    AllSeeingPi.configure do |config|
      config.aws_key = 'test_config_with_block_aws_key'
    end

    assert_equal 'test_config_with_block_aws_key', AllSeeingPi.config[:aws_key]
  end

  def test_setting_config_directly
    AllSeeingPi.config.aws_key = 'test_setting_config_directly_key'

    assert_equal 'test_setting_config_directly_key', AllSeeingPi.config[:aws_key]
  end

  def test_resetting_config
    AllSeeingPi.config.aws_key = 'test_resetting_config_key'
    AllSeeingPi.config.reset!

    assert_nil AllSeeingPi.config[:aws_key]
  end

  def test_that_config_merges_local_configuration_from_all_seeing_pi_yml
    filename = 'all_seeing_pi.yml'
    File.write(filename, "aws_key: 'test_config_merge_key'")
    AllSeeingPi.config.load_config_from_file

    assert_equal 'test_config_merge_key', AllSeeingPi.config[:aws_key]
  ensure
    FileUtils.rm(filename)
  end
end
