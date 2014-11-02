require 'test_helper'

class PalantirTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @palantir = AllSeeingPi::Palantir.new
  end

  def test_spy_sends_capture_to_the_camera
    @palantir.stubs(:store_image)
    FileUtils.stubs(:rm)

    @palantir.camera.expects(:capture).returns(@fixture)
    @palantir.spy
  end

  def test_store_image
    @palantir.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)

    @palantir.uploader.expects(:upload).with(@fixture)
    @palantir.spy
  end

  def test_spy_deletes_the_image
    @palantir.camera.stubs(:capture).returns(@fixture)
    @palantir.stubs(:store_image)

    FileUtils.expects(:rm).with(@fixture)
    @palantir.spy
  end
end
