require 'test_helper'

class GolemTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @golem = AllSeeingPi::Golem.new
  end

  def test_spy_sends_capture_to_the_camera
    @golem.stubs(:store_image)
    FileUtils.stubs(:rm)

    @golem.camera.expects(:capture).returns(@fixture)
    @golem.spy
  end

  def test_store_image
    @golem.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)

    @golem.uploader.expects(:upload).with(@fixture)
    @golem.spy
  end

  def test_spy_deletes_the_image
    @golem.camera.stubs(:capture).returns(@fixture)
    @golem.stubs(:store_image)

    FileUtils.expects(:rm).with(@fixture)
    @golem.spy
  end
end
