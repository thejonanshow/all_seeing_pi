require 'test_helper'
require 'all_seeing_eye'

class AllSeeingEyeTest < MiniTest::Unit::TestCase
  def setup
    @eye = AllSeeingEye.new
  end

  def test_spy_sends_capture_to_the_camera
    Phashion::Image.stubs(:new).returns(mock(:fingerprint))
    @eye.spy
  end

  def test_phash
    phash = @eye.phash('test/fixtures/eye_of_sauron.jpg')
    assert_equal 8540390173105289264, phash
  end

  def test_spy_gets_phash_of_image
    Phashion::Image.stubs(:new)
    @eye.camera.stubs(:capture).returns('one_ring.jpg')
    @eye.expects(:phash).with('one_ring.jpg')
    @eye.spy
  end
end
