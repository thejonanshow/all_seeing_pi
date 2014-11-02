require 'test_helper'
require 'uploader'

class CameraTest < MiniTest::Unit::TestCase
  def setup
    @camera = Camera.new
  end

  def test_capture
    # date returns 'N' for %N on OSX
    regex = /\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}-\d{9}|N\.jpg/
    assert_match regex,  @camera.capture
  end
end
