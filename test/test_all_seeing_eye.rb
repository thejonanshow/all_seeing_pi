require 'test_helper'
require 'all_seeing_eye'

class AllSeeingEyeTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @eye = AllSeeingEye.new
  end

  def test_spy_sends_capture_to_the_camera
    @eye.stubs(:store_image)
    Phashion::Image.stubs(:new).returns(mock(:fingerprint))
    @eye.spy
  end

  def test_phash
    phash = @eye.phash(@fixture)
    assert_equal 8540390173105289264, phash
  end

  def test_spy_gets_phash_of_image
    @eye.stubs(:store_image)
    Phashion::Image.stubs(:new)
    @eye.camera.stubs(:capture).returns('one_ring.jpg')
    @eye.expects(:phash).with('one_ring.jpg')
    @eye.spy
  end

  def test_store_image
    @eye.camera.stubs(:capture).returns(@fixture)
    @eye.uploader.expects(:upload).with(@fixture)
    @eye.spy
  end
end
