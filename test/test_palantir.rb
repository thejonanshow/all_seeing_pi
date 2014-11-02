require 'test_helper'

class PalantirTest < MiniTest::Unit::TestCase
  def setup
    @fixture = 'test/fixtures/eye_of_sauron.jpg'
    @palantir = AllSeeingPi::Palantir.new
  end

  def test_spy_sends_capture_to_the_camera
    @palantir.stubs(:phash)
    @palantir.stubs(:store_image)
    FileUtils.stubs(:rm)

    @palantir.camera.expects(:capture)
    @palantir.spy
  end

  def test_phash
    phash = @palantir.phash(@fixture)
    assert_equal 8540390173105289264, phash
  end

  def test_spy_gets_phash_of_image
    @palantir.camera.stubs(:capture).returns('one_ring.jpg')
    @palantir.stubs(:store_image)
    FileUtils.stubs(:rm)
    Phashion::Image.stubs(:new)

    @palantir.expects(:phash).with('one_ring.jpg')
    @palantir.spy
  end

  def test_store_image
    @palantir.camera.stubs(:capture).returns(@fixture)
    FileUtils.stubs(:rm)

    @palantir.uploader.expects(:upload).with(@fixture)
    @palantir.spy
  end

  def test_spy_deletes_the_image
    @palantir.camera.stubs(:capture).returns('one_ring.jpg')
    @palantir.stubs(:phash)
    @palantir.stubs(:store_image)

    FileUtils.expects(:rm).with('one_ring.jpg')
    @palantir.spy
  end
end
