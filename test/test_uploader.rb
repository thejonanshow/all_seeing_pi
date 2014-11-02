require 'test_helper'

class UploaderTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @filename = File.basename(@fixture)
    @uploader = AllSeeingPi::Uploader.new
    @bucket_name = AllSeeingPi::Uploader::BUCKET_PREFIX
  end

  def test_upload
    VCR.use_cassette('uploader_test_upload') do
      @uploader.upload(@fixture)
      assert @uploader.s3.buckets[@bucket_name].objects[@filename].exists?, "#{@fixture} was not uploaded."
    end
  end

  def test_fetch_or_create_bucket_name
    VCR.use_cassette('uploader_test_fetch_or_create_bucket_name') do
      name = @uploader.fetch_or_create_bucket_name(@uploader.s3.buckets)
      assert_match /#{@bucket_name}/, name
    end
  end
end
