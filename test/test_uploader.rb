require 'test_helper'

class UploaderTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @uploader = AllSeeingPi::Uploader.new
  end

  def test_upload
    VCR.use_cassette('uploader') do
      @uploader.upload(@fixture)
    end
  end
end
