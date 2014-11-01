require 'test_helper'
require 'all_seeing_eye'

class AllSeeingEyeTest < MiniTest::Unit::TestCase
  def setup
    @eye = AllSeeingEye.new
  end

  def test_all_seeing_eye_sends_capture_to_the_camera
    @eye.camera.expects(:capture)
    @eye.spy
  end
end
