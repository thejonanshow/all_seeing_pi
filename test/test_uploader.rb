require 'test_helper'

class UploaderTest < MiniTest::Unit::TestCase
  def setup
    Fog.mock!
    AllSeeingPi.config.load_config_from_file('test/all_seeing_pi.yml')

    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @filename = File.basename(@fixture)
    @uploader = AllSeeingPi::Uploader.new
  end

  def test_upload
    @uploader.upload(@fixture)
    assert @uploader.client.directories.get(@uploader.directory_name).files.head(@filename)
  end

  def test_fetch_or_create_directory_name
    name = @uploader.fetch_or_create_directory_name(@uploader.client.directories)
    assert_match /#{AllSeeingPi::Uploader::DIRECTORY_PREFIX}/, name
  end

  def test_uploader_uses_credentials_from_config
    AllSeeingPi.config[:aws_key] = 'test_key'
    AllSeeingPi.config[:aws_secret] = 'test_secret'
    uploader = AllSeeingPi::Uploader.new

    key, secret = AllSeeingPi.config[:aws_key], AllSeeingPi.config[:aws_secret]
    assert_equal ['test_key', 'test_secret'], [key, secret]
  end
end
