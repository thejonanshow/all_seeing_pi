require 'test_helper'
require 'all_seeing_eye'

class AllSeeingEyeTest < MiniTest::Unit::TestCase
  def setup
    @eye = AllSeeingEye.new
  end

  def test_spy_sends_capture_to_the_camera
    @eye.camera.expects(:capture)
    @eye.spy
  end

  def test_phash
    phash = @eye.phash('test/fixtures/eye_of_sauron.jpg')
    assert_equal 8540390173105289264, phash
  end
end
